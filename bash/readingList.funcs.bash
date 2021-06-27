function readingList ()
{
    PlistBuddy -x -c 'Print :' ~/Library/Safari/Bookmarks.plist \
            | \
        ~/Tools/xpath '//key[.="Title"]/following-sibling::string[.="com.apple.ReadingList"][1]/../array/dict/key[.="URLString"]/following-sibling::string[1]/text()'
}
