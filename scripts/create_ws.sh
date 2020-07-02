#!/usr/bin/env bash
sudo apt-get update -y 2>/dev/null
sudo apt-get install nginx -y 2>/dev/null
ctx download-resource-and-render resources/index.html '@{"target_path": "/tmp/index.html"}'
sudo mv /tmp/index.html /usr/share/nginx/html/
