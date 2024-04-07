#!/bin/bash


echo "script execution COMMON"
cd paperlessqms-common
flutter clean

echo "script execution ADMIN"
cd ../
cd paperlessqms-admin
flutter clean

echo "script execution CALL"
cd ../
cd paperlessqms-call
flutter clean

echo "script execution CLIENT"
cd ../
cd paperlessqms-client
flutter clean

echo "script execution SUPER"
cd ../
cd paperlessqms-mysuper
flutter clean

echo "script execution KIOSK"
cd ../
cd paperlessqms-kiosk
flutter clean

cd ../

echo "script execution complete"
