#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

#Set default PSQL connection variables
USER="postgres" #the postgres username for the connection
PASSWORD="" #user's password for the connection
DATABASE="postgres" #Sets connection database
HOST="localhost" #host address of the database
PORT="5432" #connection port of the database

if [ $# -gt 0 ]; then
	for var in "$@"
	do #iterate over passed command line arguments as long as one remains
	    case $1 in
	        -u | --user )           shift
	                                USER=$1
	                                echo "user: $USER"
	                                ;;

	        -p | --password )       shift
									PASSWORD=$1
	                                ;;

	        -d | --database )		shift
									DATABASE=$1
									echo "database: $DATABASE"
									;;

			-h | --host )			shift
									HOST=$1
									echo "HOST: $HOST"
									;;

			-o | --port ) 			shift
									PORT=$1
									;;

	        --help )           		echo
									echo "*****************"
									echo "This section explains the command line arguments available in this script"
									echo ""
									echo "-u <username> or --user <username> sets the username for connection to database"
									echo "-p <password> or --password <password> sets the password for the connection"
									echo "-d <database> or --database <database> sets the database for connection"
									echo "-h <host address> or --host <host address> sets the connection address for the database"
									echo "-o <port> or --port <port> sets the connection port for the database"
									echo "--help calls this output"
	                                exit
	                                ;;
	    esac
	done
fi

# Set these environmental variables to override them,
# but they have safe defaults.
export PGUSER="${PGUSER-${USER}}" #postgres user for the connection
export PGPASSWORD="${PGPASSWORD-${PASSWORD}}" #PG password for the user
export PGDATABASE="${PGDATABASE-${DATABASE}}" #Sets connection database
export PGHOST="${PGHOST-${HOST}}" #host address of the database
export PGPORT="${PGPORT-${PORT}}" #connection port of the database

echo "creating HMDA database and hmda_public schema"
echo ""
psql $PGDATABASE $PGUSER << EOF
	CREATE DATABASE hmda;
	\c hmda
	CREATE SCHEMA hmda_public;
EOF

echo "setting data paths for SQL load"
echo ""
bash write_data_paths.sh


echo "creating HMDA tables for 2018-2023"
echo ""
psql $PGDATABASE $PGUSER  << EOF
	\c hmda;
	set schema 'hmda_public';
	\i 'SQL/create_and_load_ts_2018.sql'
	\i 'SQL/create_and_load_ts_2019.sql'
	\i 'SQL/create_and_load_ts_2020.sql'
	\i 'SQL/create_and_load_ts_2021.sql'
	\i 'SQL/create_and_load_ts_2022.sql'
	\i 'SQL/create_and_load_ts_2023.sql'
	\i 'SQL/create_and_load_panel_2018.sql'
	\i 'SQL/create_and_load_panel_2019.sql'
	\i 'SQL/create_and_load_panel_2020.sql'
	\i 'SQL/create_and_load_panel_2021.sql'
	\i 'SQL/create_and_load_panel_2022.sql'
	\i 'SQL/create_and_load_panel_2023.sql'
	\i 'SQL/create_and_load_lar_2018.sql'
	\i 'SQL/create_and_load_lar_2019.sql'
	\i 'SQL/create_and_load_lar_2020.sql'
	\i 'SQL/create_and_load_lar_2021.sql'
	\i 'SQL/create_and_load_lar_2022.sql'
	\i 'SQL/create_and_load_lar_2023.sql'
EOF