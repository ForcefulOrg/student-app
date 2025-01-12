# Use an official Node.js runtime as a parent image
FROM node:18
ARG BACKEND_URL

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Replace the backend URL in the environment file
RUN echo "REACT_APP_BACKEND_URL=$BACKEND_URL" > .env

# Build the application
RUN npm run build

# Use an official Nginx image to serve the build
FROM nginx:alpine

# Copy the build output to the Nginx HTML directory
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
