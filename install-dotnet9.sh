#!/bin/bash
# add the backport repo which contains the aspnetcore-runtime-9.0 package, which will be used later to find and install dependancies
add-apt-repository -y ppa:dotnet/backports
# Update the pat database, including the new repo
apt update
# Install the default dotnet-host (version 8, as of the time of writing) and tolls used in subsequent commands
apt install -y dotnet-host apt-rdepends wget grep gawk findutils
# Find all dependancies of aspnercore-runtime-9.0, exepts for debconf (which doesn't directly install) and *dotnet* packages which would cause the removal of dotnet 8 and 7, and install them
apt-rdepends -p aspnetcore-runtime-9.0 | grep NotInstalled | grep -E -v "(dotnet)|(debconf)" | awk '/Depends:/{print$2}' | xargs apt install
# Get the offical install script and execute it, passing in the directory where dotnet-host is located, ensuring seemless integration and system-wide availability
wget -O - https://dot.net/v1/dotnet-install.sh | bash -s - --channel STS --runtime aspnetcore --install-dir $(dirname $(realpath $(which dotnet)))
