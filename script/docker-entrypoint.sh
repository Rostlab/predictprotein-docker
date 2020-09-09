#!/bin/bash
set -e

BIND_MOUNT_CONFIG_DIR="/etc/docker-predictprotein"
CONTAINER_CONFIG_STAGING_DIR="/var/tmp/config"
CONFIG_FILES=("consurfrc" "metastudentrc" "ppcache-my.cnf" "ppcacherc" "ppres_tables_mysql.sql" "predictproteinrc") 

# Copy config files from staging to bind mounts if they don't already exist
for i in "${CONFIG_FILES[@]}"
do
    if [ ! -e "${BIND_MOUNT_CONFIG_DIR}/${i}" ]
    then
        cp "${CONTAINER_CONFIG_STAGING_DIR}/${i}" "${BIND_MOUNT_CONFIG_DIR}/${i}"
    fi
done

if [ "$1" = 'predictprotein' ]; then
    exec "$@"
elif [ "$1" = 'init' ]; then
    # Copy config files from staging to bind mounts, even if they exist, starting
    # with a fresh default configuration. THIS WILL OVERWRITE EXISTING CONFIGS IN
    # YOUR BIND-MOUNTED DIRECTORY. Therefore, make a backup copy of your configs
    # before using the 'init' option.
    cat <<- EOF

	-= Initialize Configuration Files Directory =-

	You are about to overwrite any configuration files you may have existing 
	in the configuration directory, '${BIND_MOUNT_CONFIG_DIR}'.

	If you have made any customizations to any of these configuration files, 
	they will be overwritten with the default values contained in the default 
	configuration files located at '${CONTAINER_CONFIG_STAGING_DIR}'. 

	If you are using a bind mount through Docker to these configs, it's 
	recommended to make a backup of your configuration files before proceeding.

	If you're sure that you'd like to proceed, enter 'Y', if not, enter 'N' (or anything else).

	NOTE: If you've have run this option and have been immediately returned back to a prompt,
	make sure to run this Docker-run command using the '-it' command-line options. 

	EOF
    read -p "Intialize configuration directory to defaults? Are you sure? " -n 1 -r
    echo -e "\n\n" # move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "Nothing done. Exiting...\n\n"
        exit 1
    fi

    echo -e "Initializing configuration files directory, as you requested...\n"
    # User entered 'Y' or 'y'
    for i in "${CONFIG_FILES[@]}"
    do
        cp "${CONTAINER_CONFIG_STAGING_DIR}/${i}" "${BIND_MOUNT_CONFIG_DIR}/${i}"
        echo "...copied '${CONTAINER_CONFIG_STAGING_DIR}/${i}' to '${BIND_MOUNT_CONFIG_DIR}/${i}'"
    done
    echo -e "\nDone.\n\n"
    exit 0
fi

## This exec called if no other execs are called in script
exec "$@"
