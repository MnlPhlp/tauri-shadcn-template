#! /usr/bin/env bash
set -e

if [ $# -ne 2 ]; then
  echo "Usage: $0 <name> <identifier>"
  exit 1
fi

# get new and old name and identifier
name=$1
identifier=$2
identifier_android=${identifier//-/_}
path_android=${identifier_android//./\/}
echo "Renaming to '$name' with identifier '$identifier'"

identifier_old=$(jq -r ".identifier" src-tauri/tauri.conf.json)
identifier_old_android=${identifier_old//-/_}
path_old_android=${identifier_old_android//./\/}
echo "Old identifier: '$identifier_old'"

name_old=$(jq -r ".productName" src-tauri/tauri.conf.json)
echo "Old name: '$name_old'"

# change identifier
if [ "$identifier" != "$identifier_old" ]; then
  sed -i "s/\"identifier\": \"$identifier_old\"/\"identifier\": \"$identifier\"/" src-tauri/tauri.conf.json
  sed -i "s/namespace = \"$identifier_old_android\"/namespace = \"$identifier_android\"/" src-tauri/gen/android/app/build.gradle.kts
  sed -i "s/applicationId = \"$identifier_old_android\"/applicationId = \"$identifier_android\"/" src-tauri/gen/android/app/build.gradle.kts
  sed -i "s/package $identifier_old_android/package $identifier_android/" src-tauri/gen/android/app/src/main/java/${path_old_android}/MainActivity.kt
  mkdir -p src-tauri/gen/android/app/src/main/java/${path_android}
  mv src-tauri/gen/android/app/src/main/java/${path_old_android}/* src-tauri/gen/android/app/src/main/java/${path_android}/
  rmdir src-tauri/gen/android/app/src/main/java/${path_old_android}
  sed -i "s/\/src\/main\/java\/${path_old_android//\//\\\/}\/generated/\/src\/main\/java\/${path_android//\//\\\/}\/generated/" src-tauri/gen/android/app/.gitignore
fi

# change name
if [ "$name" != "$name_old" ]; then
  sed -i "s/\"productName\": \"$name_old\"/\"productName\": \"$name\"/" src-tauri/tauri.conf.json
  sed -i "s/\"title\": \"$name_old\"/\"title\": \"$name\"/" src-tauri/tauri.conf.json
  sed -i "s/\"name\": \"$name_old\"/\"name\": \"$name\"/" package.json
  sed -i "s/name = \"$name_old\"/name = \"$name\"/" src-tauri/Cargo.toml
  sed -i "s/\"app_name\">$name_old/\"app_name\">$name/" src-tauri/gen/android/app/src/main/res/values/strings.xml
  sed -i "s/\"main_activity_title\">$name_old/\"main_activity_title\">$name/" src-tauri/gen/android/app/src/main/res/values/strings.xml
fi

