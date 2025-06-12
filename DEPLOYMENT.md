# Compassion Tracker - Render Deployment Guide

This guide will help you deploy your Compassion Tracker application to Render.

## Prerequisites

- A Render account (sign up at [render.com](https://render.com))
- Your Compassion Tracker code in a Git repository (GitHub, GitLab, or Bitbucket)

## Deployment Steps

### 1. Prepare Your Repository

Ensure your repository contains these deployment files:
- `render.yaml` - Render service configuration
- `Dockerfile` - Container configuration
- `scripts/tables.sql` - Database schema
- `.dockerignore` - Files to exclude from build

### 2. Create a New Web Service on Render

1. Log into your Render dashboard
2. Click "New +" and select "Web Service"
3. Connect your Git repository
4. Choose your repository and branch (usually `main` or `master`)

### 3. Configure Build & Deploy Settings

In the Render web service setup:

**Basic Settings:**
- **Name:** `compassion-tracker`
- **Environment:** `Node`
- **Region:** Choose closest to your users
- **Branch:** `main` (or your default branch)

**Build & Deploy:**
- **Build Command:** `npm install && npm run build`
- **Start Command:** `npm start`

### 4. Set Up Environment Variables

In your Render service dashboard, go to "Environment" and add these variables:

**Required:**
- `NODE_ENV`: `production`
- `DATABASE_URL`: (Will be auto-populated when you add a database)
- `SESSION_SECRET`: Generate a random string (32+ characters)

**Optional (for email/SMS features):**
- `EMAIL_FROM`: Your sender email address
- `EMAIL_APP_PASSWORD`: Gmail app password
- `SENDGRID_API_KEY`: SendGrid API key
- `TWILIO_ACCOUNT_SID`: Twilio account SID
- `TWILIO_AUTH_TOKEN`: Twilio auth token
- `TWILIO_PHONE_NUMBER`: Twilio phone number

### 5. Create a PostgreSQL Database

1. In Render dashboard, click "New +" and select "PostgreSQL"
2. **Database Name:** `compassion-tracker-db`
3. **Database User:** `compassion_tracker_user`
4. **Region:** Same as your web service
5. **Plan:** Free (for testing) or paid plan

### 6. Connect Database to Web Service

1. In your web service settings, go to "Environment"
2. Add environment variable:
   - **Key:** `DATABASE_URL`
   - **Value:** Select "From Database" and choose your PostgreSQL database

### 7. Deploy the Application

1. Click "Manual Deploy" or push changes to trigger auto-deploy
2. Monitor the build logs for any errors
3. The app will automatically:
   - Install dependencies
   - Build the frontend and backend
   - Create database tables on first run
   - Start the server

### 8. Access Your Application

Once deployed, your app will be available at:
`https://compassion-tracker.onrender.com` (or your custom domain)

## Post-Deployment Setup

### Create Your First User Account

1. Visit your deployed application
2. Click "Register" to create your first user account
3. Create a care recipient to start tracking data

### Configure Email/SMS (Optional)

If you want medication reminders and notifications:

1. **For Gmail:** Enable 2FA and generate an app password
2. **For SendGrid:** Create account and get API key
3. **For Twilio:** Create account and get credentials
4. Add the credentials to your Render environment variables
5. Restart your service to apply changes

## Troubleshooting

### Build Fails
- Check build logs in Render dashboard
- Ensure all dependencies are in `package.json`
- Verify Node.js version compatibility

### Database Connection Issues
- Verify `DATABASE_URL` environment variable
- Check database status in Render dashboard
- Review application logs for connection errors

### Application Won't Start
- Check start command is `npm start`
- Verify `PORT` environment variable (auto-set by Render)
- Review startup logs for errors

### Environment Variables
- Ensure all required variables are set
- Check for typos in variable names
- Restart service after adding new variables

## Security Notes

- Never commit sensitive credentials to your repository
- Use Render's environment variable system for all secrets
- The application includes security headers and rate limiting
- Database connections are encrypted by default

## Performance Optimization

- Use Render's paid plans for better performance
- Enable Redis for session storage (add REDIS_URL environment variable)
- Monitor application logs for performance issues
- Consider upgrading database plan for high usage

## Custom Domain (Optional)

1. In your web service settings, go to "Settings"
2. Add your custom domain
3. Configure DNS records as shown in Render
4. SSL certificates are automatically provisioned

## Backup Strategy

- Render automatically backs up PostgreSQL databases
- Export care data regularly through the application
- Keep your Git repository as code backup

Your Compassion Tracker is now ready for production use!