#/usr/bin/sh
source_if_exists () {
    if [ -f $1 ]; then
        echo "Running $1"
        . $1
    fi;
}

source_if_exists "scripts/install.$OSTYPE.sh"
source_if_exists "scripts/install.sh"
source_if_exists "scripts/postinstall.$OSTYPE.sh"
source_if_exists "scripts/postinstall.sh"
source_if_exists "scripts/link.sh"
