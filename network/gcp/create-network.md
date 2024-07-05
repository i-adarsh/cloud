`Step 1:` Cloud VPC setup

```sh
gcloud compute networks create vpc-demo --subnet-mode custom
```

`Step 2:` Create subnets

```sh
gcloud beta compute networks subnets create vpc-demo-subnet1 \
--network vpc-demo --range 10.1.1.0/24 --region us-east1

gcloud beta compute networks subnets create vpc-demo-subnet2 \
--network vpc-demo --range 10.2.1.0/24 --region us-east4

```

`Step 3:` Create firewall rules

```sh
gcloud compute firewall-rules create vpc-demo-allow-internal \
  --network vpc-demo \
  --allow tcp:0-65535,udp:0-65535,icmp \
  --source-ranges 10.0.0.0/8

gcloud compute firewall-rules create vpc-demo-allow-ssh-icmp \
    --network vpc-demo \
    --allow tcp:22,icmp
```

`Step 4:` Create vm instances in network

```sh
gcloud compute instances create vpc-demo-instance1 --zone us-east1-b --subnet vpc-demo-subnet1 --machine-type e2-medium

gcloud compute instances create vpc-demo-instance2 --zone us-east4-c --subnet vpc-demo-subnet2 --machine-type e2-medium
```
