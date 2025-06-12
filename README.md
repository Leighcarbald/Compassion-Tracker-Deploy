# Compassion Tracker - Complete Application

## Overview
Complete caregiver support application with medication tracking, health monitoring, and emergency information management.

## Key Features
- Medication tracking with reminders
- Health metrics (blood pressure, glucose, sleep, meals)
- Emergency information with PIN protection
- Multi-recipient support with color coordination
- Secure authentication and data protection

## Deployment Instructions
1. Set up PostgreSQL database
2. Configure environment variables (see DEPLOYMENT.md)
3. Run database migrations
4. Deploy to your hosting platform

## Files Structure
All application files are included in this repository. The original folder structure should be:
- `client/` - Frontend React application
- `server/` - Express.js backend
- `shared/` - Shared schemas and types
- `db/` - Database configuration and seeds
- `scripts/` - Database setup scripts

## Environment Variables Required
- `DATABASE_URL` - PostgreSQL connection string
- `EMAIL_FROM` - Sender email address
- `EMAIL_APP_PASSWORD` - Email service password
- `REDIS_URL` - Redis connection (optional)

## Getting Started
```bash
npm install
npm run db:push
npm run db:seed
npm run dev
```

Ready for deployment on Render, Railway, or similar platforms.