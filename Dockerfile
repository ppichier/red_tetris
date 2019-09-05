FROM node:11.11 AS build-stage
WORKDIR /app
COPY package.json yarn.lock ./
RUN npm i
COPY . ./
# RUN CI=true npm test
RUN npm run build

FROM nginx:1.17
COPY --from=build-stage /app/build/ /usr/share/nginx/html
COPY --from=build-stage /app/nginx.conf /etc/nginx/conf.d/default.conf
#EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# docker build . -t ppichier/red_tetris
#docker run -p 8080:80 ppichier/red_tetris