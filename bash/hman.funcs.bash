function hman () 
{ 
	local -i ret=0
	local page # bash
	for page in "$@"
	do
		local pagePath
		pagePath="$(man --path "$page")" # /usr/share/man/man1/bash.1.gz
		[ 0 -ne $? ] && { ret=$(( $ret + 1 )); break; }

		local pageFilename="${pagePath//*\/}" # bash.1.gz

		local section="${pagePath//\/$pageFilename}" # /usr/share/man/man1
		section="${section//*\/man}" # 1

		local manCache=~/Library/Caches/man/man${section:-_} # ~/Library/Caches/man/man1
		mkdir -p "$manCache"

		local renderedPage="$manCache/$page.${section:-_}.html" # ~/Library/Caches/man/man1/bash.1.html

		if [ "$pagePath" -nt "$renderedPage" ]
		then
			local cat=cat
			if [ "${pageFilename//*.}" == "gz" ]; then
				cat=gzcat
			fi
			$cat "$pagePath" | groff -mandoc -Thtml > "$renderedPage"
		fi

		open -a Safari "$renderedPage"
	done

	return $ret
}
