function themes()
{
    if [ "$(uname)" != "Darwin" ]; then
		return
	fi
    
    open ~/.ssh/themes/terminal/Monokai.terminal
}