#!/usr/bin/env bash

set -o errexit
#set -o pipefail
set -o nounset
shopt -s failglob
set -o xtrace

apt-get install mysql-server
apt-get install -y qtcore4-l10n curl
curl -L http://sourceforge.net/projects/oscarmcmaster/files/Oscar%20Debian%2BUbuntu%20deb%20Package/oscar_em14-16beta2334.deb/download > oscar_emr14-16beta2334.deb
dpkg -i oscar_emr14-16beta2334.deb
