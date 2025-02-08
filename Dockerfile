# Base image
FROM nginx:latest

# Remove default Nginx HTML files
RUN rm -rf /usr/share/nginx/html/*

# Copy the Flutter build output to Nginx HTML directory
COPY ./build/web /usr/share/nginx/html
RUN chown nginx:nginx -R /usr/share/nginx/html

COPY ./bilit_web.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
