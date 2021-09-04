;;; ab-expand.el --- Message mode address completion with Apple's AddressBook.app

;; Copyright (C) 2003 Dirk Bernhardt
;;;; http://www.emacswiki.org/cgi-bin/wiki/DirkBernhardt
;; Author: Dirk Bernhardt <krid @ krid . de>
;; Keywords: completion, AddressBook
;; Version: 0.2 (2003-08-27)

;; $Id$

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; A copy of the GNU General Public License can be obtained from this
;; program's author (send electronic mail to tkld@quadstone.com) or
;; from the Free Software Foundation, Inc.,59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; tbd

;;; Code:

(load "message")
(require 'hippie-exp)

(defvar ab-query-program "ABQuery")
(defvar ab-query-buffer-name "*ABQuery-results*")

(defun ab-query (query-string)
  "Perform an ABQuery with QUERY-STRING, place results into *ab-query-buffer-name*."
  (let ((query-buffer (get-buffer-create ab-query-buffer-name)))
    (with-current-buffer query-buffer
      (erase-buffer)
      (call-process ab-query-program
		    nil
		    query-buffer
		    nil
		    query-string))))

(defun ab-expand-name ()
  (interactive)
  ;; narrow to search string
  (let ((beg (save-excursion
	       ;; match backwards.
	       ;; greed guarantees the longest match
	       ;; searching backwards guarantees the nearest match
	       ;; from beginning-of-line,
	       ;; either there's a ':' or a ',' and optional whitespace
	       ;; or a continuation line with ' ' or '\t' at least once
	       (if (re-search-backward "^.*[:,][ \t]*\\|^[ \t]+" nil t)
					;; "^.*\\([:,][ \t]*\\|[ \t]+\\)" nil t)
					;"[\n:,][ \t]*" "\\(\\`\\|[\n:,]\\)[ \t]*" nil t)
		   (match-end 0)
		 (point)))))
    ;; trick hippie into thinking it was the last command
    (setq this-command 'hippie-expand)
    ;; only query if neccessary
    (unless (and (equal last-command this-command)
		 (get-buffer ab-query-buffer-name))
      (ab-query (buffer-substring beg (point))))
    ;; hippie away
    (save-excursion
      (save-restriction
	(narrow-to-region beg (point))
	(let ((hippie-expand-try-functions-list '(try-expand-line-all-buffers))
	      (hippie-expand-only-buffers (list ab-query-buffer-name)))
	  (hippie-expand nil))))))

(fset 'message-expand-name #'ab-expand-name)

;;; ab-expand.el ends here

;;; ABQuery.m
; 
; /*
;  *    Copyright 2003 Brendan Cully <brendan @ kublai . com>
;  *
;  *    This program is free software; you can redistribute it and/or modify
;  *    it under the terms of the GNU General Public License as published by
;  *    the Free Software Foundation; either version 2 of the License, or
;  *    (at your option) any later version.
;  * 
;  *    This program is distributed in the hope that it will be useful,
;  *    but WITHOUT ANY WARRANTY; without even the implied warranty of
;  *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  *    GNU General Public License for more details.
;  * 
;  *    You should have received a copy of the GNU General Public License
;  *    along with this program; if not, write to the Free Software
;  *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111, USA.
;  *
;  */
; 
; #import <Foundation/Foundation.h>
; #import <AddressBook/AddressBook.h>
; 
; int main (int argc, const char *argv[]) {
;     NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
;     ABAddressBook     *book = [ABAddressBook sharedAddressBook];
;     ABSearchElement   *firstNameSearch, *lastNameSearch, *emailSearch, *search;
;     NSArray           *searchTerms;
;     NSArray           *results;
;     NSEnumerator      *addressEnum;
;     ABPerson          *person;
;     NSString          *key;
; 
;     if (argc != 2) return 1;
; 
;     key             = [NSString stringWithCString:argv[1]];
;     firstNameSearch = [ABPerson searchElementForProperty:kABFirstNameProperty
; 				label:nil
; 				key:nil
; 				value:key
; 				comparison:kABContainsSubStringCaseInsensitive];
;     lastNameSearch  = [ABPerson searchElementForProperty:kABLastNameProperty
; 				label:nil
; 				key:nil
; 				value:key
; 				comparison:kABContainsSubStringCaseInsensitive];
;     emailSearch     = [ABPerson searchElementForProperty:kABEmailProperty
; 				label:nil
; 				key:nil
; 				value:key
; 				comparison:kABContainsSubStringCaseInsensitive];
;     searchTerms     = [NSArray arrayWithObjects:firstNameSearch, lastNameSearch, emailSearch, nil];
;     search          = [ABSearchElement searchElementForConjunction:kABSearchOr
; 				       children:searchTerms];
;     results         = [book recordsMatchingSearchElement:search];
;     
;     addressEnum     = [results objectEnumerator];
;     
;     while (person = (ABPerson*)[addressEnum nextObject]) {
; 	NSString   *fullName = [NSString stringWithFormat:@"%s %s",
; 					 [[[person valueForProperty:kABFirstNameProperty] description] cString],
; 					 [[[person valueForProperty:kABLastNameProperty]  description] cString]];
; 	ABMultiValue *emails = [person valueForProperty:kABEmailProperty];
; 	int count = [emails count];
; 	int i;
; 	for (i = 0; i < count; i++) {
; 	    NSString *email = [emails valueAtIndex:i];
; 	    printf("%s <%s>\n", [fullName cString], [email cString]);
; 	}
;     }
;     
;     [pool release];
;     
;     return 0;
; }

;;; Makefile
; all: ABQuery
; 
; ABQuery: ABQuery.m
; 	gcc -O2 -framework Foundation -framework AddressBook -o ABQuery ABQuery.m
