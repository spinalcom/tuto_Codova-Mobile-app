# tuto_Codova-Mobile-app

To Start Add an SpinalHub in nerve-center

## Install mobile app


### by script

Edit the line to set your ip

```
readonly CUSTOM_IP="<YOUR IP>"
```


Usage :  ./install.sh [options] [--]

```
    Options:
    -h|help       Display this message
    -v|version    Display script version
    -i|install    Deploys the mobile app
    -d|deps       Installs dependencies  (not yet)
```

### by cmd line


in organs folder

```
cordova create mobile-app
cd mobile-app
cordova platform add android

rm -rf www
cp -r ../mobile-app_www/www .
```

Don't forget to change the IP adress in the file tuto_Codova-Mobile-app/organs/mobile-app_www/www/js/index.js and/or tuto_Codova-Mobile-app/organs/mobile-app/www/js/index.js



## Run the android app

tuto_Codova-Mobile-app/organs/mobile-app $> cordova run android

## Run the nodejs

tuto_Codova-Mobile-app/organs/print-organ $>  node ./index.js
