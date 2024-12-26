#!/bin/bash
apt update
add-apt-repository -y ppa:dotnet/backports
apt update
apt install -y dotnet-host apt-rdepends wget grep gawk findutils
apt-rdepends -p aspnetcore-runtime-9.0 | grep NotInstalled | grep -E -v "(dotnet)|(debconf)" | awk '/Depends:/{print$2}' | xargs apt install
wget -O - https://dot.net/v1/dotnet-install.sh | bash -s - --channel STS --runtime aspnetcore --install-dir $(dirname $(realpath $(which dotnet)))
