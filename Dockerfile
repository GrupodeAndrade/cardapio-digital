FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY editor.html /usr/share/nginx/html/editor.html
COPY clientes /usr/share/nginx/html/clientes

EXPOSE 80
