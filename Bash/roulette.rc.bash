roulette () 
{ 
    local teh_file="${XDG_STATE_HOME}/Untitled.txt";
    local teh_list=($( < "$teh_file" ));
    local teh_winner="$(( $RANDOM % ${#teh_list[@]} ))";
    open "${teh_list[$teh_winner]}" && perl -pi -e "s;^${teh_list[$teh_winner]};;" "$teh_file"
}
