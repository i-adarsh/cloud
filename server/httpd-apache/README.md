## Configure web server on virtual instances

`Step 1:` Launch an virtual machine

`Step 2:` SSH into the VM

`Step 3:` Upgrade its package and install web server

> Debian based: Ubuntu, Debian, ...

```sh
sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
```

> CentOS or Fedora based: RedHat, Amazon Linux, ...

```sh
sudo yum update -y
sudo yum install httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# or
# the below command start and enable the service
sudo systemctl enable httpd --now
```

`Step 4:` Pull / copy your files in the `/var/www/html` directory

```sh
git pull https://github.com/i-adarsh/cloud.git
cd cloud/server/httpd-apache/
sudo cp -r * /var/www/html/
```

`Step 5:` Restart your service

```sh
sudo systemctl restart httpd
# or
sudo systemctl restart apache2
```

**NOTE:** Verify that the firewall rule is configured correctly to ensure you can connect to the server.
