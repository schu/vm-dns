#!/bin/sh

set -e

DEBIAN_FRONTEND=noninteractive apt-get install -y \
  sqlite3 \
  pdns-server \
  pdns-backend-sqlite3

service pdns stop

cat >> /etc/powerdns/pdns.d/pdns.local <<EOF

setgid=vagrant
setuid=vagrant

recursor=8.8.8.8
allow-recursion=127.0.0.1,10.0.0.0/8,192.168.0.0/16
EOF

cat > /etc/powerdns/pdns.d/pdns.local.gsqlite3 <<EOF
launch=gsqlite3
gsqlite3-database=/vagrant/pdns.sqlite3
EOF

[ -e "/vagrant/pdns.sqlite3" ] || {
  sqlite3 /vagrant/pdns.sqlite3 < \
    /usr/share/dbconfig-common/data/pdns-backend-sqlite3/install/sqlite3
}

sleep 5 # give pdns more time to stop

service pdns start
