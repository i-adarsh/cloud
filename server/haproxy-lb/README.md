## Configure HAProxy Load balancer on virtual instances

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

`Step 4:` Pull or copy your files in the `/var/www/html` directory

```sh
git clone https://github.com/i-adarsh/cloud.git
cd cloud/server/haproxy-lb/
sudo cp index.html /var/www/html/
```

`Step 5:` Install HAProxy

> Debian based: Ubuntu, Debian, ...

```sh
sudo apt install haproxy -y
```

> CentOS or Fedora based: RedHat, Amazon Linux, ...

```sh
sudo yum install haproxy -y
```

`Step 6:` Replace the HAProxy configuration file

```sh
sudo mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy_backup.cfg
sudo vim /etc/haproxy/haproxy.cfg # Replace the IPs address
```

`Step 7:` Restart HAProxy

```sh
sudo systemctl restart haproxy
```