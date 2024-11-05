#!bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

#this file unzips the compressed Transmittal Sheet files in the data/ts directory
echo "Unzipping TS files"
for f in data/ts/*.zip; do unzip -p "$f" > "${f%.zip}.txt"; done