#!/bin/sh
profile="$1"
version="$2"

if [ -z "$2" ]; then
    echo "Usage: $0 (dev|maint|prod) buildout_version" >&2
    exit 1
fi

case "$1" in
    dev)
        sctl_name="poidev-zeo poidev-zss"
        ;;

    maint)
        sctl_name="poidev-zss poidev-zeo"
        ;;

    prod)
        sctl_name="poidev-zeo poidev-zss"
        ;;

    *)
        echo "Usage: $0 (dev|maint|prod) buildout_version" >&2
        exit 1
        ;;
esac

/usr/local/bin/supervisorctl stop $sctl_name
/usr/local/bin/svn sw https://svn.sixfeetup.com/svn/private/poidev/poidev-buildout/tags/$version
/usr/local/bin/svn up
./bin/buildout -v
/usr/local/bin/supervisorctl start $sctl_name
