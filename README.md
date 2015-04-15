# Development Environment

[![Build Status](http://jenkins.hesjevik.im/buildStatus/icon?job=development-environment)](http://jenkins.hesjevik.im/job/development-environment/) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg?style=plastic)][docker_hub_repository]

This repository contains **Dockerfiles** for development machines, and a **Vagrantfile** for a local CoreOS instance. This repository is a part of an automated build, published to the [Docker Hub][docker_hub_repository].

[docker_hub_repository]: https://registry.hub.docker.com/u/bachelorthesis/development-environment/

### Dependencies

* [VirtualBox][virtualbox] 4.3.10 or greater.
* [Vagrant][vagrant] 1.6 or greater.

[virtualbox]: https://www.virtualbox.org/
[vagrant]: https://www.vagrantup.com/

### Install

Installation is really simple, just run:

    $ sudo ./install.sh <profile>

This creates a vagrant wrapper script **gainmaster** and places it in */usr/local/bin*, which should be on your path.

## Wrapper script

By using a wrapper script we can simplify the proccess of building and accessing the inner development machine. We created a wrapper script so that you:

- Don't have to save the profile name in your environment
- Get easy access to the inner development machin
- Can access the machine from wherever you are in the terminal

If you don't want to use the wrapper, you must have **$GAINMASTER_PROFILE** in your environment.

To manualy access the development machine, first get into CoreOS with `vagrant ssh`, then enter development machine with `sudo machinectl login gainmaster`. Alternatively you can access it with: `ssh -p 2200 <profile>@127.0.0.1`

### Usage

* `gainmaster coreos` -> SSH into CoreOS machine (vagrant ssh)
* `gainmaster login` -> SSH into developer machine inside of CoreOS
* `gainmaster start` -> Start CoreOS and developer machine (vagrant up)
* `gainmaster stop` ->  Stop CoreOS and developer machin (vagrant halt)
* `gainmaster stop-force` ->  Same as taking the power out of CoreOS (vagrant halt --force)
* `gainmaster destroy` ->  Destroys CoreOS (vagrant destroy)
* `gainmaster status` -> Get CoreOS status (Running / Not running)

## Refrences

These resources have been helpful when creating this repository:

* [Youtube: PlayStation - Developing Applications on CoreOS.][playstation_developing_applications_on_coreos]
* [GitHub: CoreOS's repository for CoreOS Vagrant.][github_repository_coreos_coreos_vagrant]
* [systemd-nspawn documentation.][systemd-nspawn_documentation]
* [ArchLinux Wiki: systemd-nspawn.][archlinux_wiki_systemd_nspawn]

[playstation_developing_applications_on_coreos]: https://www.youtube.com/watch?v=M9hBsRUeRdg
[github_repository_coreos_coreos_vagrant]: https://github.com/coreos/coreos-vagrant
[archlinux_wiki_systemd_nspawn]: https://wiki.archlinux.org/index.php/Systemd-nspawn
[systemd-nspawn_documentation]: http://www.freedesktop.org/software/systemd/man/systemd-nspawn.html