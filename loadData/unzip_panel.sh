#!bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

#This file unzips the compressed Panel files in the data/panel directory.
echo "Unzipping Panel files"
for f in data/panel/*.zip; do unzip -p "$f" > "${f%.zip}.txt"; done
