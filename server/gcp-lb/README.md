```sh
#! /bin/bash
sudo apt update
sudo apt -y install apache2
git clone https://github.com/i-adarsh/cloud.git
cd cloud/server/gcp-lb/
sudo cp -r * /var/www/html/
external_ip_address=$(curl -s https://checkip.amazonaws.com)
internal_ip_address=$(hostname -I | awk '{print $1}')
file_to_replace="/var/www/html/index.html"
sudo sed -i "s/replace_with_internal_ip/$internal_ip_address/g" "$file_to_replace"
echo "Internal IP address '$ip_address' successfully inserted into '$file_to_replace'."
sudo sed -i "s/replace_with_external_ip/$external_ip_address/g" "$file_to_replace"
echo "IP address '$external_ip_address' successfully inserted into '$file_to_replace'."
sudo systemctl restart apache2
sudo systemctl enable apache2
```
