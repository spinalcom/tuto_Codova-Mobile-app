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
readonly CUSTOM_IP="YOUR IP"
readonly SCRIPTPATH="$(cd $(dirname $0); pwd -P)"
readonly ORGANPATH="$SCRIPTPATH/organs"
readonly APPPATH="$ORGANPATH/mobile-app"
readonly WWWPATH="$APPPATH/www"

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
    -v|version    Display script version"

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hv" opt
do
  case $opt in

        h|help     )  usage; exit 0   ;;

        v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
                  usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

cleanup() {
    # Remove temporary files
    # Restart services
    # ...
    echo "Nothing to be done"
}

setup_mobile() {
        cd "$ORGANPATH" || exit
        cordova create $APPNAME
        cd "$APPPATH" || exit
        cordova platform add android
        rm -rf "$WWWPATH"
        cp -r ../mobile-app_www/www . # $1 ??
}


if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    # Script goes here
    # ...
fi

