#!/bin/bash
# Reference:
# https://wiki.ubuntu.com/DebootstrapChroot
# https://wiki.ubuntu.com/SimpleSbuild

# Installing sbuild and schroot
sudo apt install sbuild debhelper ubuntu-dev-tools piuparts

# OPT: Install a local package proxy, so that downloaded packages get cached between sbuild/schroot runs:
sudo apt install apt-cacher-ng
echo 'Acquire::http::Proxy "http://127.0.0.1:3142";' | sudo tee /etc/apt/apt.conf.d/01acng

# Add yourself to sbuild group to use its capabilities
sudo adduser $USER sbuild

# Setup for mounting $HOME and extracting the ddebs:
# Create the directory for the mount point:
mkdir -p $HOME/ubuntu/scratch

# Append following line to /etc/schroot/sbuild/fstab:
/home/<username>/ubuntu/scratch  /scratch          none  rw,bind  0  0

# If you use an encrypted home directory, your $HOME is mounted differently, so you will also have to add:
/home/<username>                 /home/<username>  none  rw,bind  0  0

