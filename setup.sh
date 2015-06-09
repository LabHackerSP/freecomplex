clear
PS1="\W> "
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#bind 'set disable-completion on'
cd() {
  builtin cd "$@"
  if [ -f ".secret" ]; then
     secret=($(cat .secret))
     password $secret
  fi
  if [ -f ".env" ]; then
	   source .env
  fi
}

password() {
  echo -n "Password: "
  read password
  hash=($(echo -n "$password" | md5sum))
  if [ "$hash" == "$@" ]; then
    clear
  else
   echo "Password incorreto!"
   cd ..
  fi
}

create_secret() {
  $(echo -n "$@" | md5sum > .secret) 
  echo "Password: " $@
}
reload() {
  source $DIR/setup.sh
}