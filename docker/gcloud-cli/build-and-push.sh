#!/bin/bash

# Stop the script if any command fails
set -e

# --- Configuration ---
# Set your Google Cloud project ID, region, repository, image name, and tag.

# Your Google Cloud project ID
PROJECT_ID="adarsh"

# The region of your Artifact Registry repository (e.g., "us-central1")
REGION="asia"

# The name of your Artifact Registry repository
REPOSITORY="testing"

# The name of your Docker image
IMAGE_NAME="gcloud-cli-alpine"

# The tag for your Docker image (e.g., "latest", "v1.0.0")
IMAGE_TAG="v1"


# --- Script Logic ---

# Construct the full image URI
IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "--------------------------------------------------"
echo "🚀 Starting Docker image build and push..."
echo "--------------------------------------------------"
echo "Project ID:       ${PROJECT_ID}"
echo "Region:           ${REGION}"
echo "Repository:       ${REPOSITORY}"
echo "Image URI:        ${IMAGE_URI}"
echo "--------------------------------------------------"

# 1. Configure Docker to use gcloud as a credential helper.
# This authenticates Docker with your Artifact Registry.
echo "🔐 Configuring Docker authentication..."
gcloud auth configure-docker ${REGION}-docker.pkg.dev

echo "✅ Authentication configured."
echo ""

# 2. Build the Docker image.
# The '-t' flag tags the image with the full URI for the Artifact Registry.
# The '.' at the end specifies that the build context is the current directory.
echo "🏗️ Building the Docker image..."
docker build -t ${IMAGE_URI} .

echo "✅ Image built successfully."
echo ""

# 3. Push the Docker image to Artifact Registry.
echo "⬆️ Pushing image to Artifact Registry..."
docker push ${IMAGE_URI}

echo "✅ Image pushed successfully."
echo ""
echo "--------------------------------------------------"
echo "🎉 All done! Your image is now in Artifact Registry."
echo "--------------------------------------------------"