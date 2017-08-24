#!/usr/bin/env bash
# Author merenuou@gmail.com

set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="testGulp1"
TARGET_BRANCH="testGulp2"
PATH_='../../../../dev-scripts'

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
# if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
#     echo "Skipping deploy; just doing a build."
#     # Build here or below
#     #gulp
#     exit 0
# fi

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

git clone $REPO smi
cd smi
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH

rm -rf smi/**/* || exit 0

chmod -R +x wp-content/themes/strathcom/assets
cd wp-content/themes/strathcom/assets

ls -al

#####################################
echo 'in line 35'
npm -v
node -v
# if [[ `npm -v` != 3* ]]; then
# echo 'installing version 3'
# npm cache clean -f
# #npm install -g n
# npm i -g npm@3;
# fi

# WIP  @todo  re-add gulp and verify ssh time
touch app/index.html

# npm cache clean -f
# npm install -g n
# npm install -g bower
#npm install gulp
# npm install gulp -g
#npm update
# npm install
# ls -al
#rm -rf node_modules
# npm i -g npm-check-updates
# npm-check-updates -u
# @todo run above for quality check to kick  in
# Run gulp  Build here or above
#gulp

ls -al

pwd

#ls -al private

pwd

git config user.name "TravisAsset CI"
git config user.email "travis@strathcom.com"

# If there are no changes (e.g. this is a README update) then just bail.
if [ -z `git diff --exit-code` ]; then
    echo "No changes to the spec on this push; exiting."
    exit 0
fi

git add -A
git commit -m "Deploy to branch: ${SHA}"

# Get the deploy key
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}

# long running process
travis_wait openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in $PATH_/github_deploy_key.enc -out $PATH_/github_deploy_key -d -P

chmod 600 $PATH_/github_deploy_key
eval `ssh-agent -s`
ssh-add $PATH_/github_deploy_key
git push $SSH_REPO $TARGET_BRANCH
