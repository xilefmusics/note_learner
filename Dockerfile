FROM node:19.5.0-alpine3.17 as Builder
WORKDIR /app
COPY src .
RUN npm install &&\
    npm run build

FROM nginx:1.23.3
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=Builder /app/public .
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
