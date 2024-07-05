```sh

 BILLING_INITIATOR_EMAIL=$(gcloud iam service-accounts list --filter="Billing Initiator" --format="value(EMAIL)"); echo $BILLING_INITIATOR_EMAIL

 BILLING_SERVICE_URL=$(gcloud run services list \
  --format='value(URL)' \
  --filter="billing-service")

gcloud iam service-accounts keys create key.json --iam-account=${BILLING_INITIATOR_EMAIL}

gcloud auth activate-service-account --key-file=key.json


 curl -X POST -H "Content-Type: application/json" \
  -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
  $BILLING_SERVICE_URL -d '{"userid": "1234", "minBalance": 500}'

-----

 BILLING_INITIATOR_EMAIL=$(gcloud iam service-accounts list --filter="Billing Initiator" --format="value(EMAIL)"); echo $BILLING_INITIATOR_EMAIL

gcloud projects remove-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member=serviceAccount:${BILLING_INITIATOR_EMAIL} \
  --role=roles/run.invoker

gcloud run services add-iam-policy-binding billing-service --region $LOCATION \
  --member=serviceAccount:${BILLING_INITIATOR_EMAIL} \
  --role=roles/run.invoker --platform managed

solarized dark
```
