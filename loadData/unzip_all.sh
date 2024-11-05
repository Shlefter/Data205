#!/bin/bash

# Run in parent path regardless of working directory
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

bash unzip_and_rename_lar.sh
bash unzip_ts.sh
bash unzip_panel.sh