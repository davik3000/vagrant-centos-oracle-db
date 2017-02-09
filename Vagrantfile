# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.5.2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  _sharedFolder_software_hostPath = "./software"
  _sharedFolder_software_guestPath = "/var/tmp/vagrant/software"

  _provisionFolder_config_hostPath = "./config"
  _provisionFolder_config_guestPath = "/tmp/vagrant/config"

  _provisionScript_preInstall_hostPath = "./config/pre-install.sh"
  _provisionScript_preInstall_args = _provisionFolder_config_guestPath
  _provisionScript_postInstall_hostPath = "./config/post-install.sh"
  _provisionScript_postInstall_args = _provisionFolder_config_guestPath

  # DART official CentOS box
  config.vm.box = "centos/7"

  # db instance
  config.vm.define "oradb", primary: true do |oradb|
    oradb.vm.hostname = "oradb.example.com"
    oradb.vm.network "forwarded_port", guest: 1521, host: 1521
    oradb.vm.synced_folder ".", "/vagrant", disabled:true

    # DART check and exec only if plugin are not disabled
    if Vagrant.has_plugin?("vagrant-vbguest")
      # DART updated local folder with software installers
      oradb.vm.synced_folder _sharedFolder_software_hostPath, _sharedFolder_software_guestPath
    end

    oradb.vm.provider :virtualbox do |vb|
      vb.name = "vagrant-centos-oracle-db"
      vb.cpus = 2
      vb.memory = "2048"
    end

    oradb.vm.provision :shell do |s|
      s.path = _provisionScript_preInstall_hostPath
      s.args = [_provisionScript_preInstall_args]
    end
    # DART send config
    oradb.vm.provision :file do |f|
      f.source = _provisionFolder_config_hostPath
      f.destination = _provisionFolder_config_guestPath
    end
    # DART apply config
    oradb.vm.provision :shell do |s|
      s.path = _provisionScript_postInstall_hostPath
      s.args = [_provisionScript_postInstall_args]
    end

  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
