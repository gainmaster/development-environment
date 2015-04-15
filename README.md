# Developement Environment

[![Build Status](http://jenkins.hesjevik.im/buildStatus/icon?job=development-environment)](http://jenkins.hesjevik.im/job/development-environment/) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg?style=plastic)][docker_hub_repository]

This repository contains **Dockerfiles** for developement machines, and a **Vagrantfile** for a local CoreOS instance. This repository is a part of an automated build, published to the [Docker Hub][docker_hub_repository].

[docker_hub_repository]: https://registry.hub.docker.com/u/bachelorthesis/developement-environment/

### Dependencies

* [VirtualBox][virtualbox] 4.3.10 or greater.
* [Vagrant][vagrant] 1.6 or greater.

[virtualbox]: https://www.virtualbox.org/
[vagrant]: https://www.vagrantup.com/

## Refrences

These resources have been helpful when creating this repository:

* [Youtube: PlayStation - Developing Applications on CoreOS.][playstation_developing_applications_on_coreos]
* [GitHub: CoreOS's repository for CoreOS Vagrant.][github_repository_coreos_coreos_vagrant]

[playstation_developing_applications_on_coreos]: https://www.youtube.com/watch?v=M9hBsRUeRdg
[github_repository_coreos_coreos_vagrant]: https://github.com/coreos/coreos-vagrant