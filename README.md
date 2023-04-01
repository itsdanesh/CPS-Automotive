# Obstacle avoidance system for automotive vehicles

This current file within this branch will serve as the first primitive version of the README file for this project. We will keep this branch and constantly update the documentation on this branch gradually throughout the project.

## Prerequisites
To start using the program you need either of the following:

- [ ] [Ubuntu 22.04 LTS] (https://ubuntu.com/download/desktop) installed as operating system on your computer. 
If you have Windows or Mac:

- [ ] [VirtualBox] (https://www.virtualbox.org/wiki/Downloads), [VMware] (https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html) or [Multipass] (https://multipass.run/install) installed your computer to be able to load Ubuntu 22.04 as virtual operating system.

## Environment Installation
- [ ] Ubuntu installation [process] (https://ubuntu.com/tutorials/install-ubuntu-desktop#6-drive-management)

- [ ] Virtual Box installation [process] (https://www.howtogeek.com/796988/how-to-install-linux-in-virtualbox/),

- [ ] Multipass installation [process on Windows] (https://multipass.run/docs/installing-on-windows), [on MacOs] (https://multipass.run/docs/installing-on-macos), [on Linux] (https://multipass.run/docs/installing-on-linux)


## Running environment (for Multipass)
Once you have installed multipass, create VM by launching terminal: 
```
multipass launch 22.04 --name instancename --cpus 2 --disk 20G --memory 4G
```
To print information about instances
```
multipass list
```
To enter the VM use the command below
```
multipas shell instancename
```
Next, you need to update system's packages with commands
```
sudo apt-get update
sudo apt-get upgrade
```
And install development tools
```
sudo apt-get install build-essential cmake git
```
Then, add user to the group docker
```
sudo adduser ubuntu docker
```
For docker compose installation use following commands
```
sudo curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod ugo+x /usr/local/bin/docker-compose
```
For exchanging files between host and VM, a shared folder needs to be configured.
Logout of the VM
```
multipass exit instancename
```
Create folder on the host machine
```
mkdir exchange-folder
```
When you are in the folder that just created run following commands
```
cd ..
multipass mount data-exchange-folder instancename:/host
```

## Building

## Running tests

## Build with
- [ ] C++ (https://isocpp.org/)
- [ ] Multipass (https://multipass.run/)
- [ ] Cmake (https://cmake.org/)
- [ ] Docker (https://docs.docker.com/get-started/)
- [ ] Catch (https://github.com/catchorg/Catch2)
