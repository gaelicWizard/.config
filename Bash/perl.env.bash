#!/bin/bash
#
# Add system-perl libraries to $PERL5LIB (not custom-perl).

: ${PERL_VERSION:=$(perl -e 'print substr($^V, 1)')}
: ${BREW_PREFIX:=$(brew --prefix)}
case "${PERL5LIB:-}" in
	*$BREW_PREFIX/lib/perl5/site_perl/$PERL_VERSION/darwin-thread-multi-2level) ;;
	*) PERL5LIB="${PERL5LIB:-}${PERL5LIB:+:}$BREW_PREFIX/lib/perl5/site_perl/$PERL_VERSION/darwin-thread-multi-2level" ;;
esac
