# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'
require 'open-uri'
require 'yaml'

Vagrant.require_version ">= 1.6.0"

CLOUD_CONFIG_FILE = File.join(File.dirname(__FILE__), "cloud-config.yml")
CLOUD_CONFIG_LOCAL_FILE = File.join(File.dirname(__FILE__), "cloud-config-local.yml")

# Automatically replace the cloud-config.yaml discovery token on 'vagrant up'
token = open('https://discovery.etcd.io/new').read

data = YAML.load(IO.readlines(CLOUD_CONFIG_FILE)[1..-1].join)
data['coreos']['etcd']['discovery'] = token 

yaml = YAML.dump(data)
File.open(CLOUD_CONFIG_LOCAL_FILE, 'w') { |file| file.write("#cloud-config\n\n#{yaml}") }

# Configuration options
$update_channel = "stable"

Vagrant.configure("2") do |config|
  # Always use Vagrants insecure key
  config.ssh.insert_key = false

  config.vm.box         = "coreos-%s" % $update_channel
  config.vm.box_version = ">= 308.0.1"
  config.vm.box_url     = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % $update_channel

  config.vm.provider :virtualbox do |v|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  # Plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  config.vm.define vm_name = "gainmaster-coreos" do |config|
    config.vm.hostname = vm_name

    config.vm.network :private_network, ip: "192.168.11.100"

    config.vm.network :forwarded_port, guest: 8888, host: 8888
    config.vm.network :forwarded_port, guest: 9999, host: 9999

    config.vm.network :forwarded_port, guest: 2200, host: 2200

    config.vm.synced_folder "../", "/projects", 
      id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']

    config.vm.provision :file, 
      :source      => "#{CLOUD_CONFIG_LOCAL_FILE}", 
      :destination => "/tmp/vagrantfile-user-data"

    config.vm.provision :shell, 
      :inline     => "mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", 
      :privileged => true

    config.vm.provision :shell, path: "provision.sh"
  end

end