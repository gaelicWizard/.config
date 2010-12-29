#!/bin/sh -c 'echo This file is meant to be sourced.'

## GCC...
# Many many settings and flags for gcc based compiles... 
if [ "`uname -s`" == "Darwin" ]
then
    export MACOSX_DEPLOYMENT_TARGET="10.$((`uname -r | awk -F . '{print $1}'`-4))" 
		# Use the full feature set of the linker in the version of Darwin I'm running!
    export SDKROOT="/Developer/SDKs/MacOSX${MACOSX_DEPLOYMENT_TARGET}.sdk"
        # 
fi

export OPTFLAGS="-gstabs+ -Os" 
    # generate debugging info, but only store it _inside_ the object; 
    # optimise for speed-and-size;
    # tune for current arch.
export ARCHFLAGS="-arch_errors_fatal -arch i386 -arch x86_64" # 10.6 can't do ppc
    # Don't let "missing arch" or such get by.
    # "Universal"

export CPPFLAGS="${SDKROOT:+-sysroot=}${SDKROOT:-}"
export  LDFLAGS="${SDKROOT:+-sysroot=}${SDKROOT:-}"
    # Make sure that any searching knows where to search.

export    CFLAGS="-pipe -combine -mfix-and-continue -pie -Wall ${OPTFLAGS}"
export  CXXFLAGS="${CFLAGS}"
export OBJCFLAGS="${CFLAGS}"
    
##
export LIBTOOLIZE=glibtoolize
##

# GNU Compiler Collection aliases
 alias gcc='gcc ${CPPFLAGS:-} ${CFLAGS:-}   ${LDFLAGS:-}' 
 alias g++='g++ ${CPPFLAGS:-} ${CXXFLAGS:-} ${LDFLAGS:-}' 
 alias ugcc='gcc ${ARCHFLAGS:-}' # re-use above aliases.
 alias ug++='g++ ${ARCHFLAGS:-}'
