FROM node:14 AS build
 
WORKDIR /app
 
COPY package*.json ./
 
RUN npm install
 
COPY . .

EXPOSE 3000

RUN npm run build

FROM build AS dev

CMD ["npm", "start"]

FROM nginx:stable-alpine AS prod

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html


CMD [ "nginx", "-g", "daemon off;" ]
