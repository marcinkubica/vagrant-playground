# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://gist.github.com/roblayton/c629683ca74658412487
vms = {
    "rocky8"          => { :ip => "192.168.0.10", :vmbox => "generic/rocky8",  :cpus => 1, :mem => 1024, :ssh_port => 50210 },
    "centos7"         => { :ip => "192.168.0.11", :vmbox => "centos/7",        :cpus => 1, :mem => 1024, :ssh_port => 50211 },
    "centos8"         => { :ip => "192.168.0.12", :vmbox => "centos/8",        :cpus => 1, :mem => 1024, :ssh_port => 50212 },
    "centosstream8"   => { :ip => "192.168.0.13", :vmbox => "centos/stream8",  :cpus => 1, :mem => 1024, :ssh_port => 50213 },
    "rhel7"           => { :ip => "192.168.0.14", :vmbox => "generic/rhel7",   :cpus => 1, :mem => 1024, :ssh_port => 50214 },
    "rhel8"           => { :ip => "192.168.0.15", :vmbox => "generic/rhel8",   :cpus => 1, :mem => 1024, :ssh_port => 50215 },

  }

  Vagrant.configure("2") do |config|

    vms.each_with_index do |(hostname, cfg), index|
      config.vm.define hostname do |vm|


        vm.vm.box = "#{cfg[:vmbox   ]}"

        vm.vm.hostname = hostname

        vm.vm.provider :virtualbox do |vb|
          vb.name = hostname
          vb.memory = "#{cfg[:mem]}"
          vb.cpus = "#{cfg[:cpus]}"
        end

        vm.vm.network "private_network",
        auto_config: false,
        ip: "#{cfg[:ip]}"

        vm.vm.network "forwarded_port",
        protocol: "tcp",
        guest: 22,
        host: "#{cfg[:ssh_port]}"

        if ! "#{cfg[:k8s_port]}".empty?
          vm.vm.network "forwarded_port",
          protocol: "tcp",
          guest: "#{cfg[:k8s_port]}",
          host: "#{cfg[:k8s_port_local]}"
        end

        vm.vm.synced_folder ".", "/vagrant", disabled: true

      end
    end

    config.trigger.after :up do |trigger|
      trigger.only_on = "#{vms.to_a.last}"
      trigger.run = { path: "vagrant.sh" }
    end
  end