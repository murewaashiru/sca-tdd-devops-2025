# Multi-stage Dockerfile for fullstack application
# Stage 1: Build the React frontend
FROM node:16-alpine AS frontend-build

# Set working directory for frontend
WORKDIR /app/frontend

# Copy frontend package files
COPY mongodb-express-rest-api/app/package*.json ./

# Install frontend dependencies
RUN npm ci --only=production  --ignore-scripts

# Copy frontend source code
COPY mongodb-express-rest-api/app/ ./

# Build the React application
RUN npm run build

# Stage 2: Setup the backend and serve the application
FROM node:16-alpine AS production

# Set working directory
WORKDIR /app

ARG ATLAS_URI

# Copy backend package files
COPY mongodb-express-rest-api/server/package*.json ./

# Install backend dependencies
RUN npm ci --only=production  --ignore-scripts

# Copy backend source code
COPY mongodb-express-rest-api/server/ ./

# Copy the built frontend from the previous stage
COPY --from=frontend-build /app/frontend/build ./public

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Change ownership of the app directory
RUN chown -R nodejs:nodejs /app
USER nodejs

# Expose the port the app runs on (backend port)
EXPOSE 5050

ENV ATLAS_URI=${ATLAS_URI}

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5050 || exit 1

# Start the application
CMD ["npm", "start"]

# Build & Push to GHCR
# export GITHUB_TOKEN=YOUR_GITHUB_TOKEN
# export ATLAS_URI=<your mngodb url>
# echo $GITHUB_TOKEN | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
# docker build -t ghcr.io/YOUR_GITHUB_USERNAME/scalagos-capstone:latest .
# docker build -t ghcr.io/YOUR_GITHUB_USERNAME/scalagos-capstone:latest --build-arg ATLAS_URI=<your mngodb url> .
# If set on backend repo only docker build -t backend --build-arg ATLAS_URI=<your mngodb url> .
# docker push ghcr.io/YOUR_GITHUB_USERNAME/scalagos-capstone:latest
# docker pull ghcr.io/YOUR_GITHUB_USERNAME/scalagos-capstone:latest