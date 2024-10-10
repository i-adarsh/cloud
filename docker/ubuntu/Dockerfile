FROM ubuntu:latest

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server sudo passwd

# Create the 'test' user if it doesn't exist 
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 test 


# Set the password for the 'test' user (using the -m flag)
RUN echo 'test:test' > /tmp/passwords && \
    chpasswd -m < /tmp/passwords && \
    rm /tmp/passwords

# Start the SSH service
RUN service ssh start

# Expose port 22 for SSH
EXPOSE 22

# Run SSH in the foreground
CMD ["/usr/sbin/sshd", "-D"] 
