#!/bin/bash --fail

function PDFunlock () 
{
	local in="$1" out="$2"

	gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sPDFPassword= -dPassThroughJPEGImages=true -sOutputFile="${out}" "${in}"
}
