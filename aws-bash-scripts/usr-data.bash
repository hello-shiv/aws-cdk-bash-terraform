#!/bin/bash

# 1. User data script to install Node.js, clone the application repository, and start the application
sudo apt update -y
curl -sL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs
git clone https://github.com/hello-shiv/aws-app1-test.git /var/www/app
cd /var/www/app
npm install
npm run build
npm start -p 80


