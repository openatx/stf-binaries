#!/bin/bash -x
#
set -e

adb push node_modules/@devicefarmer/minicap-prebuilt/prebuilt/noarch/minicap.apk /data/local/tmp/

JSON=$(adb shell CLASSPATH=/data/local/tmp/minicap.apk app_process /system/bin io.devicefarmer.minicap.Main -i)

WIDTH=$(jq ".width" <<< $JSON)
HEIGHT=$(jq ".height" <<< $JSON)
ROTATION=$(jq ".rotation" <<< $JSON)

adb shell CLASSPATH=/data/local/tmp/minicap.apk app_process /system/bin io.devicefarmer.minicap.Main -P "${WIDTH}x@${HEIGHT}@${WIDTH}x${HEIGHT}/$ROTATION" -Q 80 -s > tmp.jpg
file tmp.jpg
