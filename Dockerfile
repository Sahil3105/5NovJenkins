# Stage 1: Build the application
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Stage 2: Run the application
FROM node:18-alpine

WORKDIR /app

COPY --from=build /app /app

EXPOSE 3000
CMD ["npm", "start"]

