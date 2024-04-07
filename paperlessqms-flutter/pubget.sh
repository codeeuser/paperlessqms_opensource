#!/bin/bash


echo "script execution COMMON"
cd paperlessqms-common
flutter pub get

echo "script execution ADMIN"
cd ../
cd paperlessqms-admin
flutter pub get

echo "script execution CALL"
cd ../
cd paperlessqms-call
flutter pub get

echo "script execution CLIENT"
cd ../
cd paperlessqms-client
flutter pub get

echo "script execution SUPER"
cd ../
cd paperlessqms-mysuper
flutter pub get

echo "script execution KIOSK"
cd ../
cd paperlessqms-kiosk
flutter pub get

cd ../

echo "script execution complete"
