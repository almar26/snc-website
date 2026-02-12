# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
# Choose the Server and Node Version
FROM node:20-alpine

# Create and change to the app directory.
RUN mkdir -p /usr/src/myapp
WORKDIR /usr/src/myapp

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git


# Copy the local source code from the folder to the container
COPY . .

# Install production dependencies.
RUN yarn install

# Assign ENV variables
# Bind the App to any IP
ENV NODE_ENV=production
ENV NITRO_PORT=3000
ENV NITRO_HOST=0.0.0.0

# Build the production Version of the Application
RUN yarn build

# Expose the Port Outside the container to the localhost
EXPOSE 3000

# Run Command after building the container
ENTRYPOINT [ "node", ".output/server/index.mjs" ]