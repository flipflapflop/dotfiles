# random password generator
genpasswd () {
    local l=$1
    [ "$1" == "" ] && l=20
    tr -dc A-Za-z0-9_! < /dev/urandom | head -c ${l} | xargs
}
