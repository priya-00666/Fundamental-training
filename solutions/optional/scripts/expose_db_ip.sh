#!/bin/sh
touch ~/index.html
echo "Database IP: $db_ip" >> ~/index.html
sudo cp ~/index.html /var/www/html/index.html

