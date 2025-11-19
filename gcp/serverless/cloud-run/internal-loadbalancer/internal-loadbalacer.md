export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-central1
export REPO_NAME=my-docker-repo
export SERVICE_NAME=hello-node-service

#### 2. Enable Required APIs
Enable Artifact Registry and Cloud Run.
```bash
gcloud services enable cloudbuild.googleapis.com artifactregistry.googleapis.com run.googleapis.com
```

#### 3. Create an Artifact Registry Repository
This is where your Docker images will be stored.
```bash
gcloud artifacts repositories create $REPO_NAME \
    --repository-format=docker \
    --location=$REGION \
    --description="Docker repository for Cloud Run"
```
#### 4. Build and Submit the Image
This command zips your local files, uploads them to Google Cloud Build, builds the Docker image, and stores it in the Artifact Registry you just created.
```bash
gcloud builds submit --tag $REGION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$SERVICE_NAME:v1
```
#### 5. Deploy to Cloud Run
Finally, deploy the image as a serverless service.
```bash
gcloud run deploy $SERVICE_NAME \
    --image $REGION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$SERVICE_NAME:v1 \
    --region $REGION \
    --allow-unauthenticated
```
#### 6. Verification
Once the deployment command finishes, it will output a Service URL (e.g., `https://hello-node-service-xxxxx-uc.a.run.app`). Click that link to see your styled "Hello World" application.