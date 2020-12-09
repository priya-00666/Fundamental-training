#!/bin/sh
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5
cat <<- EOF > /etc/apt/sources.list.d/mysql.list
deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7
EOF
sudo apt-get update
sudo apt-get install mysql-server-5.7 -y
sudo apt-get -f install
