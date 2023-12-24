# FROM --platform=linux/amd64 nginx:1.14.1-alpine
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# run npm run build 


# ADD ./dist/ /var/www/html
# EXPOSE 80

# #!/bin/bash   build.sh
# docker build -t -d name:verson .
# build stage

# dckr_pat_ycJv04N8x3L4zFaPWq-YlnPSWqw

FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
