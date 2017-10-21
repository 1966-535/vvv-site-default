#!/bin/bash
# this file loads all needed plugins as submodules.

REPO_GL='git@gitlab.com:'
REPO_GH='git@github.com:'
PLUGIN_DIR='../public_html/wp-content/plugins'

# read ${PLUGIN_DIR}
if [ -d ${PLUGIN_DIR} ]; then
    git submodule add -f ${REPO_GL}owllabs/metumaribe-utility.git ${PLUGIN_DIR}/metumaribe-utility
    git submodule add -f ${REPO_GL}qasa/deals-wordpress-plugin.git ${PLUGIN_DIR}/deals-wordpress-plugin
    git submodule add -f ${REPO_GH}Metumaribe/easy-digital-downloads.git ${PLUGIN_DIR}/easy-digital-downloads
    git submodule add -f ${REPO_GH}Metumaribe/WordPress-Admin-Style.git ${PLUGIN_DIR}/WordPress-Admin-Style
    git submodule add -f ${REPO_GH}Metumaribe/timber.git ${PLUGIN_DIR}/timber
else
    echo "That directory doesn't exists"
fi
