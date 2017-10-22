#!/bin/bash
# This file loads all needed plugins as submodules.
# DO NOT LINK TO AUTO SETUP!!

REPO_GL='git@gitlab.com:'
REPO_GH='git@github.com:'
PLUGIN_DIR='../public_html/wp-content/plugins'
THEME_DIR='../public_html/wp-content/themes'
WP_URL='https://downloads.wordpress.org/plugin'


if [ -d ${PLUGIN_DIR} ]; then
    # delete submodules first @todo add a check for presence of submodules
    # deinit all submodules from .gitmodules
    git submodule deinit .
    git rm --cached .
    rm -rf .git/modules/*

    # remove all submodules (`git rm`) from .gitmodules
    git submodule | cut -c43- | while read -r line; do (git rm "${line}"); done

    # delete all submodule sections from .git/config (`git config --local --remove-section`) by fetching those from .git/config
    git config --local -l | grep submodule | sed -e 's/^\(submodule\.[^.]*\)\(.*\)/\1/g' | while read -r line; do (git config --local --remove-section "${line}"); done

    # manually remove leftovers
    # cat ../.gitmodules
    rm -rf ../.git/modules
    git rm -r --cached add-submodules.sh

    # Delete the plugins
    rm -rf ${PLUGIN_DIR}/*


    # Add base submodules
    git submodule add -f ${REPO_GL}owllabs/metumaribe-utility.git ${PLUGIN_DIR}/metumaribe-utility
    git submodule add -f ${REPO_GL}qasa/deals-wordpress-plugin.git ${PLUGIN_DIR}/deals-wordpress-plugin
    git submodule add -f ${REPO_GH}Metumaribe/easy-digital-downloads.git ${PLUGIN_DIR}/easy-digital-downloads
    git submodule add -f ${REPO_GH}Metumaribe/WordPress-Admin-Style.git ${PLUGIN_DIR}/WordPress-Admin-Style
    git submodule add -f ${REPO_GH}Metumaribe/wp-redis.git ${PLUGIN_DIR}/wp-redis
    if [ -d ${THEME_DIR} ]; then
        git submodule add -f ${REPO_GH}Metumaribe/timber-bootstrap.git ${THEME_DIR}/timber-bootstrap
    else
        echo "${THEME_DIR} doesn't exists"
    fi
else
    echo "${PLUGIN_DIR} doesn't exists"
fi

# Install from WordPress.org
cd ${PLUGIN_DIR}

file_out=$(curl -o ./timber-library.zip ${WP_URL}'/timber-library.zip' 2>&1)

if [[ $? -eq 0 && ${file_out} ]]; then
 # install debug files
 curl -o ./rewrite-rules-inspector.1.2.1.zip ${WP_URL}'/rewrite-rules-inspector.1.2.1.zip'
 curl -o ./wp-crontrol.1.5.zip ${WP_URL}'/wp-crontrol.1.5.zip'
 curl -o ./transients-manager.zip ${WP_URL}'/transients-manager.zip'
 curl -o ./email-log.2.2.0.zip ${WP_URL}'/email-log.2.2.0.zip'
 curl -o ./query-monitor.2.15.0.zip ${WP_URL}'/query-monitor.2.15.0.zip'

 # Unzip all files
 # unzip *.zip
 find ./ -name \*.zip -exec unzip {} \;
 rm -rf *.zip
 ls -al

 rm -rf ${PLUGIN_DIR}/wp-crontrol/*
fi
