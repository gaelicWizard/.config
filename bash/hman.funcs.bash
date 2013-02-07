function hman () 
{ 
	local page # bash
	for page in "$@"
	do
		local pathToPage="$(man --path "$page")" # /usr/share/man/man1/bash.1.gz
		local pageFilename="${pathToPage//*\/}" # bash.1.gz

		local section="${pathToPage//\/$pageFilename}" # /usr/share/man/man1
		section="${section//*\/man}" # 1

		local manCache=~/Library/Caches/man/man${section:-_} # ~/Library/Caches/man/man1
		mkdir -p "$manCache"

		local manCacheRender="$manCache/$page.$section.html" # ~/Library/Caches/man/man1/bash.1.html

		local cat=cat
		if [ "${pathToPage//*.}" == "gz" ]; then
			cat=gzcat
		fi
		$cat "$pathToPage" | groff -mandoc -Thtml > "$manCacheRender"

		open -a Safari "$manCacheRender"
	done
}
