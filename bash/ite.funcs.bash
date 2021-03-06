#!/bin/bash --login

function dvdmedia2ite ()
{
    ite="$1"
        # The path to a copy of Apple's iTunes Extras template, version 2.0.
    dvdmedia="$2"
        # The path to a ripInit()'d .dvdmedia bundle.

    albumTitle="$(defaultsReadAtomicMetadata "$dvdmedia" Album album)"
    albumArtist="$(defaultsReadAtomicMetadata "$dvdmedia" Album albumArtist)"

    perl -pi -e 's;iTunes Extra for Movie;'"${albumTitle}"';g' "${ite}/index.html"
        # Name it (shows in iTunes title bar).
    
}