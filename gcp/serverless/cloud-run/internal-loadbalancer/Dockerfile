# Use the official lightweight Node.js 18 image.
# https://hub.docker.com/_/node
FROM node:18-alpine

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this first allows Docker to cache dependencies if package.json hasn't changed.
COPY package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . .

# Cloud Run requires the container to listen on port 8080 by default.
ENV PORT 8080

# Run the web service on container startup.
CMD [ "npm", "start" ]