# How to Identify and Remove Unused Service Accounts in Google Cloud

Unused service accounts can pose a security risk to your Google Cloud project. By identifying and removing them, you can reduce your attack surface and improve your overall security posture.

## Steps to Find Unused Service Accounts:

### Enable the Recommender API

In the Google Cloud Console, go to the APIs & Services page and search for [Recommender API](https://console.cloud.google.com/flows/enableapi?apiid=recommender.googleapis.com&redirect=https://console.cloud.google.com) and click `Enable` if it's not already enabled.

### Install the gcloud CLI

If not installed, run the below command:

```sh
curl -sSL https://sdk.cloud.google.com | bash
```

### Check Required IAM Roles

**For viewing insights:** `Recommender Viewer (roles/recommender.iamViewer)`

**For modifying insights:** `Recommender Admin (roles/recommender.iamAdmin)`

> (Custom roles can be used if they include the permissions below.)

**View permissions:**

- `recommender.iamServiceAccountInsights.get`

- `recommender.-iamServiceAccountInsights.list`

**Modify permissions:**

- `recommender.iamServiceAccountInsights.update`

### List All Unused / Inactive Service Accounts

```sh
gcloud recommender insights list --insight-type=google.iam.serviceAccount.Insight \
    --project=PROJECT_ID \
    --location=global
```

:::note
Replace your-project-id with the actual ID of your Google Cloud project.
:::

### Get simple List of Service Accounts

```sh
gcloud recommender insights list --insight-type=google.iam.serviceAccount.Insight \
    --project=PROJECT_ID \
    --location=global
    --format='value(DESCRIPTION)'
```

### Review the output:

![output](https://raw.githubusercontent.com/i-adarsh/cloud/refs/heads/main/gcp/IAM/service-account/unused-service-account.png)

The command will output a list of all the service account insights for your project, including any unused service accounts.

Each insight will include information such as the service account name, the last used time, and the recommended action.
Take action:

For each unused service account, you can either delete it or disable it.
If you're not sure whether a service account is still needed, you can disable it first and then monitor it for any activity.
