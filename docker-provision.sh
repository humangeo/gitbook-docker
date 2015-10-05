#!/bin/sh -eux
# docker-provision.sh --- Provisioning script for a Docker container w/GitBook.
GITBOOK_VERSION="0.3.6"

# update Apt repositories
apt-get update

# install dependencies
apt-get install -y --no-install-recommends git #calibre

# install GitBook CLI
npm install -g gitbook-cli@$GITBOOK_VERSION

# install the latest version...gets installed in $HOME (i.e. /root)
gitbook versions:install latest

# add commonly used GitBook plugins
npm install -g gitbook-plugin-include-codeblock


# clean up (apt)
apt-get clean     # remove packages that have been downloaded, installed, and no longer needed
apt-get autoclean # remove archived packages that can no longer be downloaded

# clean up (misc.)
rm -rf /var/lib/apt/lists/* /var/cache/apt/* /root/.npm

# Add empty docs directory
mkdir -p /docs
