clear
PS1="\W> "
bind 'set disable-completion on'
cd() {
  builtin cd "$@"
  clear
  if [ -f ".env" ]; then
	source .env
  fi
}
