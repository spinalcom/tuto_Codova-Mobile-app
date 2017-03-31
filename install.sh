#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage: ./install.sh
#/ Description: Basic script allowing to build/rebuild your mobile app
#/ Examples:
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage


readonly APPNAME="mobile-app"
readonly LOG_FILE="/tmp/$(basename "$0").log"
readonly CUSTOM_IP="<YOUR IP>"
readonly SCRIPTPATH="$(cd "$(dirname "$0")"; pwd -P)"
readonly ORGANPATH="$SCRIPTPATH/organs"
readonly APPPATH="$ORGANPATH/mobile-app"
readonly WWWPATH="$APPPATH/www"

cleanup() {
    # Remove temporary files
    # Restart services
    # ...
    echo "Nothing to be done"
}

setup_mobile() {
        if [ "$CUSTOM_IP" == "<YOUR IP>" ];
        then
                echo "Please edit the script and replace <YOUR IP>."
                exit 1
        fi
        cd "$ORGANPATH" || exit
        cordova create $APPNAME
        cd "$APPPATH" || exit
        cordova platform add android
        rm -rf "$WWWPATH"
        cp -r ../mobile-app_www/www . # $1 ??
	sed -i "s/XX.XX.XX.XX/$CUSTOM_IP/g"  "$WWWPATH/js/index.js"
}

deps() {
        echo "TBD."
        exit 3
}

__ScriptVersion="1.0"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
        echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    -i|install    Deploys the mobile app
    -d|deps       Installs dependencies " #TODO

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

main() {
        while getopts ":hvi" opt
        do
          case $opt in

                h|help     )  usage; exit 0   ;;

                v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

                i|install  ) setup_mobile; exit 0    ;;

                d|deps     ) deps; exit 0 ;;
                * )  echo -e "\n  Option does not exist : $OPTARG\n"
                          usage; exit 1   ;;

          esac    # --- end of case ---
        done
        shift $((OPTIND-1))
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    main "$*"
fi

