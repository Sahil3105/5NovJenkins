# Stage 1: Build the application
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Set a different npm cache directory for later stages
ENV NPM_CONFIG_CACHE=/tmp/.npm

# Stage 2: Run the application
FROM node:18-alpine

# Add a new user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=build /app /app

# Change to the new user
USER appuser

EXPOSE 3000
CMD ["npm", "start"]
