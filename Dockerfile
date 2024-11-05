# Stage 1: Build the application
FROM node:18 AS build

WORKDIR /app

# Copy package files and install all dependencies, including dev dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Run the application
FROM node:18-alpine

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Install dev dependencies to ensure mocha is available
RUN npm install --only=dev

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
