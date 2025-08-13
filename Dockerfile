FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/dist /usr/share/nginx/html
