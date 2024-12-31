# Stage 1: Install Dependencies
FROM node:16-alpine AS dependencies

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

# Stage 2: Production
FROM node:16-alpine

WORKDIR /app

COPY --from=dependencies /app/package.json /app/package-lock.json ./
COPY --from=dependencies /app/node_modules /app/node_modules
COPY --from=dependencies /app /app

EXPOSE 3333

CMD ["node", "server.js"] 
