#!/bin/bash
# this file loads all needed plugins as submodules.

REPO_GL='git@gitlab.com:owllabs'
PLUGIN_DIR='../public_html/wp-content/plugins'

# read ${PLUGIN_DIR}
if [ -d ${PLUGIN_DIR} ]; then
    git submodule add -f ${REPO_GL}/metumaribe-utility.git ${PLUGIN_DIR}/metumaribe-utility
    git submodule add -f git@gitlab.com:qasa/deals-wordpress-plugin.git ${PLUGIN_DIR}/deals-wordpress-plugin
    git submodule add -f ${REPO_GL}/owl-deals.git ${PLUGIN_DIR}/owl-deals
else
    echo "That directory doesn't exists"
fi
