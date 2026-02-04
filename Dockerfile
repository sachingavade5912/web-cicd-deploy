# Use nginx as a base image
FROM nginx:alpine

# Copy web application files to nginx html directory
COPY . /html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]