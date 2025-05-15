# Use official Node.js image to build the app
FROM node:20 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Use official nginx image to serve the build
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]

# Configure nginx to listen on port 8080
RUN sed -i 's/80;/8080;/g' /etc/nginx/conf.d/default.conf
