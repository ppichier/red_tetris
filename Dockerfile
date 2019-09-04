FROM node:11.11 AS build-deps
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
run npm i
COPY . ./
RUN npm build

FROM nginx:1.17-alpine
COPY --from:build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# docker build . -t ppichier/red_tetris
#docker run -p 8080:80 ppichier/red_tetris