;; UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;;

;; EmacsServer
(set 'server-kill-new-buffers t)
;(add-hook 'server-done-hook 'delete-frame)
(add-hook 'after-init-hook 'server-start)
;;

;; Syntax Highlighting
(global-font-lock-mode t)
;;

;; Always use tabs
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
;;

;; Make title bar meaningful
(setq frame-title-format "%b - Emacs")
;;

;; Ensure trailing newline
(setq require-final-newline 't)
;;

;; Prevent suspend when window'd
(when window-system
 (global-unset-key "\C-z")) ; iconify-or-deiconify-frame (C-x C-z)
;;

;; The Matrix Reloaded?
(defconst animate-n-steps 3) 
  (defun emacs-reloaded ()
    (animate-string (concat ";; Initialization successful, welcome to "
  			  (substring (emacs-version) 0 16)
			  ".")
		  0 0)
    (newline-and-indent)  (newline-and-indent))
  (add-hook 'after-init-hook 'emacs-reloaded)  
;;

;; Auto Compile Init
(defun byte-compile-user-init-file ()
 (let ((byte-compile-warnings '(unresolved)))
  ;; in case compilation fails, don't leave the old .elc around:
  (when (file-exists-p (concat user-init-file "c"))
   (delete-file (concat user-init-file "c")))
  (byte-compile-file user-init-file)
  ;; (message "%s compiled" user-init-file)
  ))
(defun my-emacs-lisp-mode-hook ()
 (when (equal buffer-file-name user-init-file)
  (add-hook 'after-save-hook 'byte-compile-user-init-file t t)))
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)
;;

;; Organize by Package
;; default emacs configuration directory
;(defconst jp:emacs-config-dir "~/.emacs.d/" "")
;; utility finction to auto-load my package configurations
;(defun jp:load-config-file (filelist)
;  (dolist (file filelist)
;    (load (expand-file-name 
;           (concat jp:emacs-config-dir file)))
;     (message "Loaded config file:%s" file)
;     ))
;; load my configuration files
;(jp:load-config-file '("mswindows_config"
;                        "frames_config"
;                        "info_config"
;                        "desktop_config"
;                        "efs_config"
;                        "backup_config"
;                        "modemaps_config"
;                       ))
;;

;;;(add-to-list 'load-path "~/.emacs.d")
;;;
;;;; My PHP setup
;;;
;;;(require 'setup-php-drupal)
;;;(setup-php-drupal)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

;(require 'mac-pseudo-daemon)
