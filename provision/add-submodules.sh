#!/bin/bash
# This file loads all needed plugins as submodules.
# DO NOT LINK TO AUTO SETUP!!

REPO_GL='git@gitlab.com:'
REPO_GH='git@github.com:'
PLUGIN_DIR='../public_html/wp-content/plugins'
THEME_DIR='../public_html/wp-content/themes'

if [ -d ${PLUGIN_DIR} ]; then
    git submodule add -f ${REPO_GL}owllabs/metumaribe-utility.git ${PLUGIN_DIR}/metumaribe-utility
    git submodule add -f ${REPO_GL}qasa/deals-wordpress-plugin.git ${PLUGIN_DIR}/deals-wordpress-plugin
    git submodule add -f ${REPO_GH}Metumaribe/easy-digital-downloads.git ${PLUGIN_DIR}/easy-digital-downloads
    git submodule add -f ${REPO_GH}Metumaribe/WordPress-Admin-Style.git ${PLUGIN_DIR}/WordPress-Admin-Style
    git submodule add -f ${REPO_GH}Metumaribe/timber.git ${PLUGIN_DIR}/timber
    if [ -d ${THEME_DIR} ]; then
        git submodule add -f ${REPO_GH}Metumaribe/branch.git ${THEME_DIR}/branch
        git submodule add -f ${REPO_GH}Metumaribe/timber-bootstrap.git ${THEME_DIR}/timber-bootstrap
    else
        echo "${THEME_DIR} doesn't exists"
    fi
else
    echo "${PLUGIN_DIR} doesn't exists"
fi
# DO NOT LINK TO AUTO SETUP!!
