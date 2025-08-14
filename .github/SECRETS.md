# GitHub Actions Secrets Configuration Guide

This document outlines the required secrets for the CI/CD pipeline.

## Required Secrets

### For GitHub Container Registry (GHCR) - Automatic
- `GITHUB_TOKEN` - Automatically provided by GitHub Actions

### For Docker Hub (Optional Alternative)
- `DOCKER_HUB_USERNAME` - Your Docker Hub username
- `DOCKER_HUB_ACCESS_TOKEN` - Docker Hub access token (not password)

### For Render Deployment (Optional)
Choose one of the following methods:

#### Method 1: Deploy Hook URL (Recommended)
- `RENDER_DEPLOY_HOOK_URL` - Your Render service deploy hook URL
- `RENDER_APP_URL` - Your deployed app URL (for summary display)

#### Method 2: Render API
- `RENDER_API_KEY` - Your Render API key
- `RENDER_SERVICE_ID` - Your Render service ID
- `RENDER_APP_URL` - Your deployed app URL (for summary display)

### For MongoDB Atlas
- `MONGO_URI` - Your MongoDB Atlas connection string

## How to Add Secrets

1. Go to your GitHub repository
2. Click on `Settings` tab
3. Navigate to `Secrets and variables` → `Actions`
4. Click `New repository secret`
5. Add each secret with the exact name listed above

## Render Deploy Hook Setup

1. Log in to your Render dashboard
2. Go to your service settings
3. Navigate to the `Deploy` section
4. Copy the "Deploy Hook" URL
5. Add it as `RENDER_DEPLOY_HOOK_URL` secret in GitHub

## Docker Hub Access Token Setup

1. Log in to Docker Hub
2. Go to `Account Settings` → `Security`
3. Click `New Access Token`
4. Name it (e.g., "GitHub Actions")
5. Copy the token and add it as `DOCKER_HUB_ACCESS_TOKEN` secret

## Environment Variables for Render

Make sure to set these environment variables in your Render service:
- `PORT=5050`
- `MONGO_URI=<your-mongodb-atlas-connection-string>`
- `NODE_ENV=production`
