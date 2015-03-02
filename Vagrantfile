# -*- mode: ruby -*-
# vi: set ft=ruby :

_script = <<SCRIPT
set -o errexit
#set -o pipefail
set -o nounset
shopt -s failglob
set -o xtrace

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y curl wkhtmltopdf
wget --no-check-certificate https://github.com/aglover/ubuntu-equip/raw/master/equip_java7_64.sh && bash equip_java7_64.sh
sudo apt-get install -y tomcat7 libmysql-java curl maven curl wkhtmltopdf
sed -i 's|\#JAVA_HOME=.*|JAVA_HOME=/usr/lib/jvm/jdk1.7.0_65|' /etc/default/tomcat7

SCRIPT

begin
  LXC_VERSION = `lxc-ls --version`.strip
rescue
  LXC_VERSION = '0'
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 3084
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.provider "lxc" do |lxc, override|
    override.vm.box = "fgrehm/trusty64-lxc"
    if LXC_VERSION >= '1.1.0'
      lxc.customize 'aa_allow_incomplete', '1'
    end
  end

  config.vm.provision "shell", inline: _script
  config.vm.network "forwarded_port", guest: 8443, host: 8443
end
