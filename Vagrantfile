# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64-server-cloudimg"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.hostname = "dns"
  config.vm.network "private_network", ip: "10.8.8.8"

  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "shell", inline: "apt-get install -y git screen"

  config.vm.provision "shell", path: "setup-pdns.sh"
end
