#! /bin/bash
apt update
apt -y install apache2
git clone https://github.com/i-adarsh/cloud.git
cp -r cloud/server/startup-script/* /var/www/html
external_ip_address=$(curl -s https://checkip.amazonaws.com)
internal_ip_address=$(hostname -I | awk '{print $1}')
file_to_replace="/var/www/html/index.html"
sed -i "s/replace_with_internal_ip/$internal_ip_address/g" "$file_to_replace"
sed -i "s/replace_with_external_ip/$external_ip_address/g" "$file_to_replace"
systemctl restart apache2 
systemctl enable apache2


#! /bin/bash
yum update -y
yum -y install httpd git
git clone https://github.com/i-adarsh/cloud.git
cp -r cloud/server/startup-script/* /var/www/html
external_ip_address=$(curl -s https://checkip.amazonaws.com)
internal_ip_address=$(hostname -I | awk '{print $1}')
file_to_replace="/var/www/html/index.html"
sed -i "s/replace_with_internal_ip/$internal_ip_address/g" "$file_to_replace"
sed -i "s/replace_with_external_ip/$external_ip_address/g" "$file_to_replace"
systemctl restart httpd 
systemctl enable httpd