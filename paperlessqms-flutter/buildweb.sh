#!/bin/bash


echo "script execution COMMON"
cd paperlessqms-common
flutter pub get

echo "script execution ADMIN"
cd ../
cd paperlessqms-admin
flutter build web

echo "script execution CALL"
cd ../
cd paperlessqms-call
flutter build web

echo "script execution CLIENT"
cd ../
cd paperlessqms-client
flutter build web

echo "script execution SUPER"
cd ../
cd paperlessqms-mysuper
flutter build web

echo "script execution KIOSK"
cd ../
cd paperlessqms-kiosk
flutter build web

cd ../

echo "script execution complete"
