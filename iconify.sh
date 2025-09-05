#!/bin/bash

if [ $# -ne 3 ]; then
    echo "usage: bash iconify.sh BUNDLE_NAME PATH SF_ICON"
    exit 2
fi

DST=$1

SRC="CustomFinderSidebarIcon"
rm -r build
mkdir -p build

# copy...
cp -R ${SRC}s                                  "build/${DST}"
cp -R ${SRC}s.xcodeproj                        "build/${DST}.xcodeproj"
cp -R ${SRC}Sync                               "build/${DST}Sync"


# rename assets...
mv "build/${DST}/${SRC}s.entitlements"            "build/${DST}/${DST}.entitlements"
mv "build/${DST}Sync/${SRC}Sync.entitlements"     "build/${DST}Sync/${DST}Sync.entitlements"


# replace text...
/usr/bin/sed -i '' "s/${SRC}s/${DST}/g"        "build/${DST}.xcodeproj/project.pbxproj"
/usr/bin/sed -i '' "s/${SRC}Sync/${DST}Sync/g" "build/${DST}.xcodeproj/project.pbxproj"
/usr/bin/sed -i '' "s/${SRC}s/${DST}/g"        "build/${DST}.xcodeproj/project.xcworkspace/contents.xcworkspacedata"
/usr/bin/sed -i '' "s/${SRC}s/${DST}/g"        "build/${DST}.xcodeproj/xcuserdata/robb.xcuserdatad/xcschemes/xcschememanagement.plist"
/usr/bin/sed -i '' "s/${SRC}Sync/${DST}Sync/g" "build/${DST}.xcodeproj/xcuserdata/robb.xcuserdatad/xcschemes/xcschememanagement.plist"

USRPATH=$2
ICON=$3

/usr/bin/sed -i '' "s/flame/$ICON/g"                 "build/${DST}/info.plist"
/usr/bin/sed -i '' "s#PATH_GOES_HERE#${USRPATH}#g"   "build/${DST}Sync/URLs"



# and build
rm   -rf "dist/${DST}"
mkdir -p "dist/${DST}"

xcodebuild -project build/${DST}.xcodeproj -scheme ${DST} -derivedDataPath "dist/${DST}"
mv "dist/${DST}/Build/Products/Debug/${DST}.app" "dist/"

# cleanup
rm -r "dist/${DST}"