#!/usr/bin/env bash
# Provision file

_DB_='test_default'
_USER_='wp'

# Make a database, if we don't already have one
echo -e "\nCreating database '${_DB_}' (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS ${_DB_} "
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON ${_DB_}.* TO ${_USER_}@localhost IDENTIFIED BY '${_USER_}';"
echo -e "\n DB operations done.\n\n"

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/log
touch ${VVV_PATH_TO_SITE}/log/error.log
touch ${VVV_PATH_TO_SITE}/log/access.log

# Install and configure.
if [[ ! -d "${VVV_PATH_TO_SITE}/public_html" ]]; then

  echo "Setting up"
  cd ${VVV_PATH_TO_SITE}
  mkdir ${VVV_PATH_TO_SITE}/public_html
  touch ${VVV_PATH_TO_SITE}/public_html/index.php

else
  echo "Didn't workout"
fi
