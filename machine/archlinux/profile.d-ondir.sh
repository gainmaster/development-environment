cd()
{
	builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

pushd()
{
	builtin pushd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

popd() 
{
	builtin popd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}              

# Run ondir on login
eval "`ondir /`"