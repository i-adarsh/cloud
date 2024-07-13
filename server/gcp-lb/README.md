```sh
#! /bin/bash
apt update
apt -y install apache2
git clone https://github.com/i-adarsh/cloud.git
cp -r cloud/server/gcp-lb/* /var/www/html/
external_ip_address=$(curl -s https://checkip.amazonaws.com)
internal_ip_address=$(hostname -I | awk '{print $1}')
file_to_replace="/var/www/html/index.html"
sed -i "s/replace_with_internal_ip/$internal_ip_address/g" "$file_to_replace"
echo "Internal IP address '$ip_address' successfully inserted into '$file_to_replace'."
sed -i "s/replace_with_external_ip/$external_ip_address/g" "$file_to_replace"
echo "IP address '$external_ip_address' successfully inserted into '$file_to_replace'."
systemctl restart apache2
systemctl enable apache2
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
```

```sh
#!/bin/bash
yum update -y
yum install -y httpd git
git clone https://github.com/i-adarsh/cloud.git
cp -r cloud/server/gcp-lb/* /var/www/html/
external_ip_address=$(curl -s https://checkip.amazonaws.com)
internal_ip_address=$(hostname -I | awk '{print $1}')
file_to_replace="/var/www/html/index.html"
sed -i "s/replace_with_internal_ip/$internal_ip_address/g" "$file_to_replace"
echo "Internal IP address '$ip_address' successfully inserted into '$file_to_replace'."
sed -i "s/replace_with_external_ip/$external_ip_address/g" "$file_to_replace"
echo "IP address '$external_ip_address' successfully inserted into '$file_to_replace'."
systemctl start httpd
systemctl enable httpd
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
```
