FROM nginx:alpine
COPY index.htmk /usr/share/nginx/html/index.html
EXPOSE 80
