# Builder Stage
FROM node:lts-slim AS builder

WORKDIR /app

# Copy package.json and package-lock.json first to install dependencies
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Copy the rest of the app source code
COPY . .

# Run the build step
RUN npm run build

# Production Stage
FROM node:lts-slim

WORKDIR /app

# Copy only the necessary artifacts from the builder stage
COPY --from=builder /app /app

# Run the app
CMD [ "npm", "run", "start" ]
