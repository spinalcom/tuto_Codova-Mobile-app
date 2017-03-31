# tuto_Codova-Mobile-app


To Start Add an SpinalHub in nerve-center

## Install mobile app
in organs folder

cordova create mobile-app
cd mobile-app
cordova platform add android

rm -rf www
cp -r ../mobile-app_www/www .


## Run the android app

tuto_Codova-Mobile-app/organs/mobile-app $> cordova run android

## Run the nodejs

tuto_Codova-Mobile-app/organs/print-organ $>  node ./index.js