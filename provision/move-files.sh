#!/bin/bash
# Moves files to desktop.

# Common paths
PLUGIN_DIR='../public_html/wp-content/plugins'
THEME_DIR='../public_html/wp-content/themes'
DESTINATION_LOCATION='Desktop/git-file-output'

#copy
rm -rf ~/${DESTINATION_LOCATION}
mkdir ~/${DESTINATION_LOCATION}
cp -R ${PLUGIN_DIR} ~/${DESTINATION_LOCATION}
cp -R ${THEME_DIR} ~/${DESTINATION_LOCATION}

echo 'See files below'
ls ~/${DESTINATION_LOCATION}/*
