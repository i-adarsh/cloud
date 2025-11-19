```sh
gcloud services enable run.googleapis.com
LOCATION="us-east1"

gcloud config set compute/region $LOCATION
gcloud config set run/region $LOCATION


gcloud run deploy product-service \
   --image gcr.io/qwiklabs-resources/product-status:0.0.1 \
   --tag test1 \
   --region $LOCATION \
   --allow-unauthenticated

TEST1_PRODUCT_SERVICE_URL=$(gcloud run services describe product-service --platform managed --region us-east4 --format="value(status.address.url)")

curl $TEST1_PRODUCT_SERVICE_URL/help -w "\n"

gcloud run deploy product-service \
  --image gcr.io/qwiklabs-resources/product-status:0.0.2 \
  --no-traffic \
  --tag test2 \
  --region=$LOCATION \
  --allow-unauthenticated

TEST2_PRODUCT_STATUS_URL=$(gcloud run services describe product-service --platform managed --region=us-east4 --format="value(status.traffic[1].url)")

curl $TEST2_PRODUCT_STATUS_URL/help -w "\n"

```

## Revision migration

```sh
gcloud run services update-traffic product-service \
  --to-tags test2=50 \
  --region=$LOCATION

for i in {1..10}; do curl $TEST1_PRODUCT_SERVICE_URL/help -w "\n"; done

```

## Tagged revision rollback

In the event an issue is found, the traffic migration can be rolled back by resetting the percentage.

```sh
gcloud run services update-traffic product-service \
  --to-tags test2=0 \
  --region=$LOCATION

for i in {1..10}; do curl $TEST1_PRODUCT_SERVICE_URL/help -w "\n"; done
```

## Traffic migration

```sh

gcloud run deploy product-service \
  --image gcr.io/qwiklabs-resources/product-status:0.0.3 \
  --no-traffic \
  --tag test3 \
  --region=$LOCATION \
  --allow-unauthenticated

gcloud run deploy product-service \
  --image gcr.io/qwiklabs-resources/product-status:0.0.4 \
  --no-traffic \
  --tag test4 \
  --region=$LOCATION \
  --allow-unauthenticated

gcloud run services describe product-service \
  --region=$LOCATION \
  --format='value(status.traffic.revisionName)'

LIST=$(gcloud run services describe product-service --platform=managed --region=$LOCATION --format='value[delimiter="=25,"](status.traffic.revisionName)')"=25"

gcloud run services update-traffic product-service \
  --to-revisions $LIST --region=$LOCATION

gcloud run services update-traffic product-service \
  --to-revisions product-service-00001-fow=25,product-service-00002-vun=25,product-service-00005-kah=25,product-service-00006-sid=25 --region=$LOCATION

```

## Traffic splitting - update traffic between revisions

Reset the service traffic profile to use the latest deployment:

```sh
gcloud run services update-traffic product-service --to-latest --platform=managed --region=$LOCATION

LATEST_PRODUCT_STATUS_URL=$(gcloud run services describe product-service --platform managed --region=$LOCATION --format="value(status.address.url)")

curl $LATEST_PRODUCT_STATUS_URL/help -w "\n"
```
