#!/bin/bash --fail

PATH="/Library/Perl/bin:$PATH"

##
# Set some defaults for Perl.
# moved to ~/.MacOSX/environment.plist
##

# Unicode, if locale is appropriate.
#export PERL_UNICODE="IOEioAL"
# see ~/.MacOSX/environment.plist

# Fix up some neglected defaults from Config.pm for use with ExtUtils::MakeMaker.
#export PERL_MM_OPT="INSTALLSITEBIN=/Library/Perl/bin
#                    INSTALLSITESCRIPT=/Library/Perl/bin
#                    INSTALLSITEMAN1DIR=/Library/Perl/man/man1
#                    INSTALLSITEMAN3DIR=/Library/Perl/man/man3
#                    
#                    INSTALLVENDORBIN=/Network/Library/Perl/bin
#                    INSTALLVENDORSCRIPT=/Network/Library/Perl/bin
#                    INSTALLVENDORMAN1DIR=/Network/Library/Perl/man/man1
#                    INSTALLVENDORMAN3DIR=/Network/Library/Perl/man/man3
#
#                    INSTALLBIN=/Library/Perl/Updates/bin
#                    INSTALLSCRIPT=/Library/Perl/Updates/bin
#                    INSTALLMAN1DIR=/Library/Perl/Updates/man/man1
#                    INSTALLMAN3DIR=/Library/Perl/Updates/man/man3
#                    "

