## Startup script for configuring web server on VMs

> Debian based: Ubuntu, Debian, ...

```sh
#! /bin/bash
# This line specifies that the script should be run using the Bash shell.

# Update the package lists to ensure the latest information is available
apt update

# Install the Apache2 web server
apt -y install apache2

# Clone Git repository named 'cloud' from GitHub
git clone https://github.com/i-adarsh/cloud.git

# Copy the contents of a specific directory from the cloned repository to the web server's root directory
cp -r cloud/server/gcp-lb/* /var/www/html/

# Get the server's external IP address Amazon AWS
external_ip_address=$(curl -s https://checkip.amazonaws.com)

# Get the server's internal IP address
internal_ip_address=$(hostname -I | awk '{print $1}')

# Define the path to the index.html file where we'll replace the IP placeholders
file_to_replace="/var/www/html/index.html"

# Replace the string "replace_with_internal_ip" in the index.html with the actual internal IP address
sed -i "s/replace_with_internal_ip/$internal_ip_address/g" "$file_to_replace"
echo "Internal IP address '$internal_ip_address' successfully inserted into '$file_to_replace'." # Confirm successful replacement

# Replace the string "replace_with_external_ip" in the index.html with the actual external IP address
sed -i "s/replace_with_external_ip/$external_ip_address/g" "$file_to_replace"
echo "External IP address '$external_ip_address' successfully inserted into '$file_to_replace'." # Confirm successful replacement

# Restart the Apache2 service to apply the changes
systemctl restart apache2

# Enable Apache2 to start automatically at boot time
systemctl enable apache2

# Set permissions on the /var/www directory (web root):
# - 2775: Owner (root) gets full permissions, group (www-data) gets read/write/execute, others get read/execute.
# - The 's' bit (setgid) means new files/directories created within will inherit the group ownership (www-data).
chmod 2775 /var/www

# Apply the same permissions recursively to all directories within /var/www
find /var/www -type d -exec chmod 2775 {} \;

# Apply file permissions to all files within /var/www:
# - 0664: Owner (root) gets read/write, group (www-data) gets read/write, others get read.
find /var/www -type f -exec chmod 0664 {} \;

```

> CentOS or Fedora based: RedHat, Amazon Linux, ...

```sh
#!/bin/bash
# This line specifies that the script should be run using the Bash shell.

# Update all installed packages to their latest versions
yum update -y

# Install the Apache HTTP Server (httpd) and Git
yum install -y httpd git

# Clone a Git repository named 'cloud' from GitHub
git clone https://github.com/i-adarsh/cloud.git

# Copy the contents of a specific directory from the cloned repository to the web server's root directory
cp -r cloud/server/gcp-lb/* /var/www/html/

# Get the server's external IP address from Amazon AWS's Check IP service
external_ip_address=$(curl -s https://checkip.amazonaws.com)

# Get the server's internal IP address
internal_ip_address=$(hostname -I | awk '{print $1}')

# Define the path to the index.html file where we'll replace the IP placeholders
file_to_replace="/var/www/html/index.html"

# Replace all occurrences of "replace_with_internal_ip" in the index.html with the actual internal IP address
sed -i "s/replace_with_internal_ip/$internal_ip_address/g" "$file_to_replace"
echo "Internal IP address '$internal_ip_address' successfully inserted into '$file_to_replace'." # Confirm successful replacement

# Replace all occurrences of "replace_with_external_ip" in the index.html with the actual external IP address
sed -i "s/replace_with_external_ip/$external_ip_address/g" "$file_to_replace"
echo "External IP address '$external_ip_address' successfully inserted into '$file_to_replace'." # Confirm successful replacement

# Start the Apache HTTP Server
systemctl start httpd

# Enable the Apache HTTP Server to start automatically on boot
systemctl enable httpd

# Add the 'ec2-user' to the 'apache' group (this is common on Amazon EC2 instances)
usermod -a -G apache ec2-user

# Change the owner of the /var/www directory and its contents to 'ec2-user' and the group to 'apache'
chown -R ec2-user:apache /var/www

# Set permissions on the /var/www directory (web root):
# - 2775: Owner (ec2-user) gets full permissions, group (apache) gets read/write/execute, others get read/execute.
# - The 's' bit (setgid) means new files/directories created within will inherit the group ownership (apache).
chmod 2775 /var/www

# Apply the same permissions recursively to all directories within /var/www
find /var/www -type d -exec chmod 2775 {} \;

# Apply file permissions to all files within /var/www:
# - 0664: Owner (ec2-user) gets read/write, group (apache) gets read/write, others get read.
find /var/www -type f -exec chmod 0664 {} \;
```
