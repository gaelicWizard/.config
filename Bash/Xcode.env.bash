#!/bin/bash --fail

## Controls for compiling from source, e.g. Xcode, GCC, LLVM, autoconf, automake, &c.

return # temporarily disabled...

# Specific to Mac OS X
if [ "`uname -s`" == "Darwin" ]
    # If we're on Mac OS X:
then
:
#    export MACOSX_DEPLOYMENT_TARGET="10.$((`uname -r | awk -F . '{print $1}'`-4))" 
        # Use the full feature set of the linker in the version of Darwin I'm running!
        # All system packages were compiled with this, and some local packages must be compiled with the matching setting.
#    export IPHONEOS_DEPLOYMENT_TARGET="3.1.3" # The last version to run on the original iPhone, up from default "2.0".

    # Make sure that any searching knows where to search.
#    export DEVELOPER_DIR="$(xcode-select -print-path 2>/dev/null)"
        # xcode-select determines which relocatable Xcode owns the non-relocatable "UNIX" tools.
        # $DEVELOPER_DIR overrides xcode-select's setting, which we want since we're _partially_ overriding it next:
#    export DEVELOPER_USR_DIR="${DEVELOPER_DIR:=/Developer}/usr"
#    export GCC_EXEC_PREFIX="${DEVELOPER_DIR}/usr/lib/gcc/" # trailing slash
        # Use the compiler _inside_ the Xcode root.
        # For some unknown reason, GCC is compiled with --prefix=/usr (but seemingly with --libdir /lib, and _something_ makes it want to search /usr/lib/../../libexec/gcc or some such.), even though it is housed inside the relocatable /Developer hierarchy. 
#    export SDKROOT="${DEVELOPER_DIR}/SDKs/MacOSX${MACOSX_DEPLOYMENT_TARGET}.sdk"
        # Use the most-recent SDK.
#    export CPPFLAGS+="${CPPFLAGS:+ }${SDKROOT:+-isysroot }${SDKROOT:-}"
#    export  LDFLAGS+="${LDFLAGS:+ }${SDKROOT:+-isysroot }${SDKROOT:-}"
        # Apple's docs say to use -isysroot instead of --sysroot.

#    export ARCHS="$(ls /usr/libexec/gcc/darwin 2>/dev/null)"
        # Universal. 
            # 64-bit PowerPC support is lacking, and only Mac OS X 10.5 ever supported 64-bit Cocoa on PowerPC.
            # We generate the list of architectures to build for by simply checking which architectures the compiler supports.
            # Mac OS X 10.7 does not support building for ppc _at all_.
            # NOTE: that $ARCHS is reassigned next-
#    export ARCHFLAGS="-arch_errors_fatal $(for arch in ${ARCHS:=x86_64 i386}; do printf -- "-arch $arch "; done)"
        # Don't let "missing arch" or such get by.

    #OBJCXFLAGS: Flags to use for _either_ Obj-C _or_ Obj-C++, see OBJCFLAGS and OBJCXXFLAGS below.
#    OBJCXFLAGS+="${OBJCXFLAGS:+ }-fobjc-gc" # -fzero-link
        # Enable garbage collection support.
#    export LDFLAGS+="${LDFLAGS:+ }-pie"
        # Produce a position independent executable, assumes -fPIC (default on Darwin).
fi

# Convenience variables.
#DEBUGFLAGS+="${DEBUGFLAGS:+ }-gstabs+"
    # generate debugging info, but only store it _inside_ the object (don't generate an external dSYM bundle).
OPTFLAGS+="${OPTFLAGS:+ }-Os" 
    # Optimize for size, but not at the expense of speed. 
WARN64BIT="-Wimplicit-function-declaration -Wshorten-64-to-32"
    # implicit function declarations might indicate an argument size mismatch when building 64-bit (from previously 32-bit code).
    # warn about truncating 64-bit sized variables.
WARNFLAGS+="${WARNFLAGS:+ }${WARN64BIT:-} -Wall -Werror -Wnewline-eof -Wfour-char-constants -Wwrite-strings -Wredundant-decls -Wunreachable-code -Winline -Wdisabled-optimization"
    # Demand well-formed code.
#-Wstack-protector -fstack-protector
#-Q -ftime-report -fmem-report -time
#-fopt-diary, requires -gdwarf-2


#CPATH: Colon-separated list of -I paths. GCC and Clang.
#LIBRARY_PATH: -L paths. GCC only.
#CXFLAGS: Flags to use for all compiler invocations, see C.*FLAGS below.
CXFLAGS+="${CXFLAGS:+ }-pipe -Wall ${OPTFLAGS:-}"
    # -pipe: reduce temp-files usage, and allows for partially parallelised compile-assemble.
    # -Wall: be verbose by default.
    # $OPTFLAGS: Optimise build.
#C.*FLAGS: Flags to use whenever the language-specific compiler may be invoked, per-language.
#CPPFLAGS: Flags to use whenever the c-preprocessor may be invoked.
#LDFLAFGS: Flags to use whenever the linker may be invoked.
export        CFLAGS+="${CFLAGS:+ }${CXFLAGS:-}"
export      CXXFLAGS+="${CXXFLAGS:+ }${CXFLAGS:-} -fvisibility-inlines-hidden"
export     OBJCFLAGS+="${OBJCFLAGS:+ }${OBJCXFLAGS:-} ${CFLAGS:-}"
export   OBJCXXFLAGS+="${OBJCXXFLAGS:+ }${OBJCXFLAGS:-} ${CXXFLAGS:-}"

# Additional arguments to gcc can be passed _in a file_ by adding @/path/to/file to CFLAGS.
    
##
export LIBTOOLIZE=glibtoolize
##


# Easy Access
alias   cc='cc  ${CPPFLAGS:-} ${CFLAGS:-}   ${LDFLAGS:-}' 
alias  c++='c++ ${CPPFLAGS:-} ${CXXFLAGS:-} ${LDFLAGS:-}' 
alias  ucc='cc  ${ARCHFLAGS:-}'
alias uc++='c++ ${ARCHFLAGS:-}'
