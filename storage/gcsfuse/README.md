export GCSFUSE_REPO=gcsfuse-focal

echo "deb https://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

apt-get install curl gnupg -y

apt-get install fuse gcsfuse python3 -y

curl -sSL https://sdk.cloud.google.com | bash
