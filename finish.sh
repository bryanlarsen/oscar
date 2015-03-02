#!/usr/bin/env bash

set -o errexit
#set -o pipefail
set -o nounset
shopt -s failglob
set -o xtrace

apt-get install mysql-server
curl -L http://sourceforge.net/projects/oscarmcmaster/files/Oscar%20Debian%2BUbuntu%20deb%20Package/oscar_emr14-16beta2334.deb/download > oscar_emr14-16beta2334.deb
dpkg -i oscar_emr14-16beta2334.deb
apt-get install -y maven
service tomcat7 restart
