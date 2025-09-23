# Fiscility Environment Variables Configuration

## Overview
This document provides comprehensive information about all environment variables used across Fiscility's infrastructure, including backend, frontend, and website services.

## Third-Party Service Variables

### ActiveCampaign (Email Marketing)
- **ACTIVECAMPAIGN_API_KEY**: API key for ActiveCampaign integration
  - **Source**: ActiveCampaign account dashboard
  - **Purpose**: Authentication for email marketing automation and lead management
  - **Services**: Backend only
  - **Format**: String (alphanumeric key)

- **ACTIVECAMPAIGN_KEY**: Alternative/legacy ActiveCampaign key
  - **Source**: ActiveCampaign account settings
  - **Purpose**: Secondary authentication method for ActiveCampaign services
  - **Services**: Backend only
  - **Format**: String

- **ACTIVECAMPAIGN_URL**: Base URL for ActiveCampaign API
  - **Source**: ActiveCampaign account configuration
  - **Purpose**: Defines the endpoint for ActiveCampaign API calls
  - **Services**: Backend only
  - **Format**: URL (e.g., `https://yourcompany.api-us1.com`)

### ClickSend (SMS Services)
- **CLICKSEND_PASSWORD**: Password for ClickSend API authentication
  - **Source**: ClickSend account credentials
  - **Purpose**: Authentication for SMS and communication services
  - **Services**: Backend only
  - **Format**: String

- **CLICKSEND_USERNAME**: Username for ClickSend API authentication
  - **Source**: ClickSend account credentials
  - **Purpose**: User identification for ClickSend services
  - **Services**: Backend only
  - **Format**: String

### OpenAI (AI Services)
- **OPENAI_API_KEY**: API key for OpenAI GPT services
  - **Source**: OpenAI platform dashboard
  - **Purpose**: Access to GPT models for financial analysis and insights
  - **Services**: Backend only
  - **Format**: String starting with `sk-`

### Plaid (Banking Integration)
- **PLAID_CLIENT_ID**: Client identifier for Plaid banking API
  - **Source**: Plaid dashboard
  - **Purpose**: Identifies your application to Plaid services
  - **Services**: Backend only
  - **Format**: String (UUID-like format)

- **PLAID_COUNTRY_CODES**: Supported country codes for Plaid
  - **Source**: Configured based on business requirements
  - **Purpose**: Defines which countries' banks can be connected
  - **Services**: Backend only
  - **Format**: Comma-separated string (e.g., `US,CA,GB`)

- **PLAID_ENV**: Plaid environment setting
  - **Source**: Configuration choice (sandbox/development/production)
  - **Purpose**: Determines which Plaid environment to use
  - **Services**: Backend only
  - **Format**: String (`sandbox`, `development`, or `production`)

- **PLAID_PRODUCTS**: Plaid products to access
  - **Source**: Configuration array defined in code
  - **Purpose**: Specifies which Plaid services to use (transactions, balance, etc.)
  - **Services**: Backend only
  - **Format**: Array in code: `["transactions", "balance"]`

- **PLAID_SECRET**: Secret key for Plaid API authentication
  - **Source**: Plaid dashboard
  - **Purpose**: Authentication for secure Plaid API access
  - **Services**: Backend only
  - **Format**: String (long alphanumeric key)

### Stripe (Payment Processing)
- **STRIPE_ENDPOINT_SECRET**: Webhook endpoint secret for Stripe
  - **Source**: Stripe dashboard webhook configuration
  - **Purpose**: Validates incoming webhook requests from Stripe
  - **Services**: Backend only
  - **Format**: String starting with `whsec_`

- **STRIPE_KEY**: Stripe API secret key
  - **Source**: Stripe dashboard
  - **Purpose**: Authentication for Stripe payment processing
  - **Services**: Backend only
  - **Format**: String starting with `sk_`

### Supabase (Database & Authentication)
- **SUPABASE_JWT_SECRET**: JWT secret for token validation
  - **Source**: Supabase project settings
  - **Purpose**: Validates JWT tokens for authentication
  - **Services**: Backend only
  - **Format**: String (long random key)

- **SUPABASE_KEY**: Supabase service role key
  - **Source**: Supabase project API settings
  - **Purpose**: Server-side authentication for database operations
  - **Services**: Backend and Frontend
  - **Format**: String starting with `eyJ`

- **SUPABASE_SERVICE_KEY**: Service role key for backend operations
  - **Source**: Supabase project API settings
  - **Purpose**: Full access key for server-side database operations
  - **Services**: Backend only
  - **Format**: String starting with `eyJ`

- **SUPABASE_URL**: Base URL for Supabase project
  - **Source**: Supabase project settings
  - **Purpose**: Endpoint for Supabase API and database access
  - **Services**: Backend and Frontend
  - **Format**: URL (e.g., `https://project-id.supabase.co`)

### Redis (Caching)
- **REDIS_URL**: Connection URL for Redis cache
  - **Source**: Redis hosting provider (Railway, Heroku, etc.)
  - **Purpose**: Caching layer for improved performance
  - **Services**: Backend only
  - **Format**: URL (e.g., `redis://localhost:6379` or `rediss://...`)

### MongoDB (Database)
- **MONGODB_URI**: Connection string for MongoDB
  - **Source**: MongoDB Atlas or self-hosted instance
  - **Purpose**: Document database for storing application data
  - **Services**: Backend only
  - **Format**: URI (e.g., `mongodb+srv://user:pass@cluster.mongodb.net/db`)

### Sentry (Error Monitoring)
- **SENTRY_BACKEND_DSN**: Data Source Name for backend error tracking
  - **Source**: Sentry project settings
  - **Purpose**: Error monitoring and performance tracking for backend
  - **Services**: Backend only
  - **Format**: URL starting with `https://`

- **SENTRY_FRONTEND_DSN**: Data Source Name for frontend error tracking
  - **Source**: Sentry project settings
  - **Purpose**: Error monitoring for frontend application
  - **Services**: Frontend only
  - **Format**: URL starting with `https://`

### Rewardful (Affiliate Tracking)
- **REWARDFUL_API_SECRET**: API secret for Rewardful affiliate system
  - **Source**: Rewardful dashboard
  - **Purpose**: Manages affiliate tracking and commissions
  - **Services**: Backend only
  - **Format**: String

## Application Configuration Variables

### Security & Internal
- **ENCRYPTION_KEY**: Key for encrypting sensitive data
  - **Source**: Generated secure random key
  - **Purpose**: Encrypts sensitive information before storage
  - **Services**: Backend only
  - **Format**: String (32+ character random key)

- **INTERNAL_SECRET**: Secret for internal service communication
  - **Source**: Generated secure random key
  - **Purpose**: Authenticates requests between internal services
  - **Services**: Backend only
  - **Format**: String

- **SCHEDULE_TRIGGER_SECRET**: Secret for scheduled job authentication
  - **Source**: Generated secure random key
  - **Purpose**: Validates scheduled task triggers
  - **Services**: Backend only
  - **Format**: String

### URLs & Endpoints
- **ENDPOINT_URL**: Base URL for backend API
  - **Source**: Deployment configuration
  - **Purpose**: Defines the backend API endpoint
  - **Services**: Backend, Frontend, Website
  - **Format**: URL (e.g., `https://api.fiscility.com`)

- **FRONTEND_URL**: Base URL for frontend application
  - **Source**: Deployment configuration
  - **Purpose**: CORS configuration and redirects
  - **Services**: Backend, Frontend, Website
  - **Format**: URL (e.g., `https://app.fiscility.com`)

- **WEBSITE_URL**: Base URL for marketing website
  - **Source**: Deployment configuration
  - **Purpose**: Marketing site and public pages
  - **Services**: Backend, Frontend, Website
  - **Format**: URL (e.g., `https://fiscility.com`)

## Frontend Public Variables (NEXT_PUBLIC_*)

### API Configuration
- **NEXT_PUBLIC_API_URL**: Backend API URL accessible to frontend
  - **Source**: Deployment configuration
  - **Purpose**: Frontend API calls to backend services
  - **Services**: Frontend and website
  - **Format**: URL

- **NEXT_PUBLIC_APP_URL**: Frontend application URL
  - **Source**: Deployment configuration
  - **Purpose**: Self-referencing URL for redirects and sharing
  - **Services**: Frontend and website
  - **Format**: URL

- **NEXT_PUBLIC_SITE_URL**: Website application URL
  - **Source**: Deployment configuration
  - **Purpose**: Self-referencing URL for redirects and sharing
  - **Services**: Frontend and website
  - **Format**: URL

### Analytics & Tracking
- **NEXT_PUBLIC_POSTHOG_HOST**: PostHog analytics host URL
  - **Source**: PostHog configuration
  - **Purpose**: Analytics and user behavior tracking
  - **Services**: Frontend only
  - **Format**: URL (e.g., `https://app.posthog.com`)

- **NEXT_PUBLIC_POSTHOG_KEY**: PostHog project API key
  - **Source**: PostHog project settings
  - **Purpose**: Analytics tracking identification
  - **Services**: Frontend only
  - **Format**: String

- **NEXT_PUBLIC_GA_MEASUREMENT_ID**: Google Analytics measurement ID
  - **Source**: Google Analytics property settings
  - **Purpose**: Website traffic and conversion tracking
  - **Services**: Website
  - **Format**: String starting with `G-`

### Client-Side Services
- **NEXT_PUBLIC_SUPABASE_ANON_KEY**: Supabase anonymous key for frontend
  - **Source**: Supabase project API settings
  - **Purpose**: Client-side authentication and database access
  - **Services**: Frontend only
  - **Format**: String starting with `eyJ`

- **NEXT_PUBLIC_SUPABASE_URL**: Supabase URL accessible to frontend
  - **Source**: Supabase project settings
  - **Purpose**: Client-side connection to Supabase services
  - **Services**: Frontend only
  - **Format**: URL (e.g., `https://project-id.supabase.co`)

## Environment-Specific Deployment Notes

### Security Considerations
- All non-`NEXT_PUBLIC_*` variables should be kept secure and never exposed to client-side code
- `NEXT_PUBLIC_*` variables are visible in the browser and should only contain non-sensitive configuration
- Service keys should be rotated regularly and stored securely in deployment platforms
- Use different keys for development, staging, and production environments

### Service Dependencies
- **Backend**: Requires all non-`NEXT_PUBLIC_*` variables plus shared URL variables
- **Frontend**: Requires all `NEXT_PUBLIC_*` variables, Supabase variables, and shared URL variables  
- **Website**: Requires `NEXT_PUBLIC_API_URL`, `NEXT_PUBLIC_APP_URL`, `NEXT_PUBLIC_SITE_URL`, `NEXT_PUBLIC_GA_MEASUREMENT_ID`, and shared URL variables

### Variable Relationships
- **NEXT_PUBLIC_API_URL** ↔ **ENDPOINT_URL**: Both should have the same value
- **NEXT_PUBLIC_APP_URL** ↔ **FRONTEND_URL**: Both should have the same value  
- **NEXT_PUBLIC_SITE_URL** ↔ **WEBSITE_URL**: Both should have the same value

### Deployment Checklist
1. Ensure all required variables are set in your deployment platform
2. Verify URLs match your actual deployed services
3. Test that API keys have appropriate permissions
4. Confirm environment-specific settings (sandbox vs production for Plaid, Stripe)
5. Validate that CORS settings allow your frontend domains


| Variable                     | Source                                | Purpose                                                      | Format                               | Backend | Frontend | Website |
|------------------------------|---------------------------------------|--------------------------------------------------------------|--------------------------------------|---------|----------|---------|
| ACTIVECAMPAIGN_API_KEY       | ActiveCampaign dashboard              | Authentication for email marketing automation                | String                               | ✅      | ❌       | ❌      |
| ACTIVECAMPAIGN_KEY           | ActiveCampaign settings               | Secondary authentication method                              | String                               | ✅      | ❌       | ❌      |
| ACTIVECAMPAIGN_URL           | ActiveCampaign configuration          | Defines API endpoint                                         | URL                                  | ✅      | ❌       | ❌      |
| CLICKSEND_PASSWORD           | ClickSend credentials                 | Authentication for SMS services                              | String                               | ✅      | ❌       | ❌      |
| CLICKSEND_USERNAME           | ClickSend credentials                 | User identification for ClickSend                            | String                               | ✅      | ❌       | ❌      |
| OPENAI_API_KEY               | OpenAI dashboard                      | Access GPT models                                            | String starting with `sk-`            | ✅      | ❌       | ❌      |
| PLAID_CLIENT_ID              | Plaid dashboard                       | Identifies app to Plaid                                      | String                               | ✅      | ❌       | ❌      |
| PLAID_COUNTRY_CODES          | Business configuration                | Defines supported countries                                  | Comma-separated string                | ✅      | ❌       | ❌      |
| PLAID_ENV                    | Config setting                        | Selects Plaid environment                                    | `sandbox` / `development` / `production` | ✅   | ❌       | ❌      |
| PLAID_PRODUCTS               | Config (code)                         | Defines Plaid services to use                                | Array (e.g. ["transactions"])         | ✅      | ❌       | ❌      |
| PLAID_SECRET                 | Plaid dashboard                       | Authentication for Plaid API                                 | String                               | ✅      | ❌       | ❌      |
| STRIPE_ENDPOINT_SECRET       | Stripe webhook settings               | Validates Stripe webhooks                                    | String starting with `whsec_`         | ✅      | ❌       | ❌      |
| STRIPE_KEY                   | Stripe dashboard                      | Stripe API authentication                                    | String starting with `sk_`            | ✅      | ❌       | ❌      |
| SUPABASE_JWT_SECRET          | Supabase settings                     | Validates JWT tokens                                         | String                               | ✅      | ❌       | ❌      |
| SUPABASE_KEY                 | Supabase API settings                 | Server-side + client auth                                    | String starting with `eyJ`            | ✅      | ✅       | ❌      |
| SUPABASE_SERVICE_KEY         | Supabase API settings                 | Full access for server-side operations                       | String starting with `eyJ`            | ✅      | ❌       | ❌      |
| SUPABASE_URL                 | Supabase settings                     | API/database endpoint                                        | URL                                  | ✅      | ✅       | ❌      |
| REDIS_URL                    | Redis provider                        | Connection string for Redis cache                            | URL (redis:// / rediss://)            | ✅      | ❌       | ❌      |
| MONGODB_URI                  | MongoDB Atlas/self-hosted             | Connection string for MongoDB                                | URI (mongodb+srv://...)               | ✅      | ❌       | ❌      |
| SENTRY_BACKEND_DSN           | Sentry settings                       | Error monitoring (backend)                                   | URL                                  | ✅      | ❌       | ❌      |
| SENTRY_FRONTEND_DSN          | Sentry settings                       | Error monitoring (frontend)                                  | URL                                  | ❌      | ✅       | ❌      |
| REWARDFUL_API_SECRET         | Rewardful dashboard                   | Affiliate tracking                                           | String                               | ✅      | ❌       | ❌      |
| ENCRYPTION_KEY               | Generated                             | Encrypts sensitive data                                      | String (32+ chars)                    | ✅      | ❌       | ❌      |
| INTERNAL_SECRET              | Generated                             | Auth for internal service communication                      | String                               | ✅      | ❌       | ❌      |
| SCHEDULE_TRIGGER_SECRET      | Generated                             | Auth for scheduled tasks                                     | String                               | ✅      | ❌       | ❌      |
| ENDPOINT_URL                 | Deployment config                     | Backend API base URL                                         | URL                                  | ✅      | ✅       | ✅      |
| FRONTEND_URL                 | Deployment config                     | Frontend base URL (CORS/redirects)                           | URL                                  | ✅      | ✅       | ✅      |
| WEBSITE_URL                  | Deployment config                     | Marketing site base URL                                      | URL                                  | ✅      | ✅       | ✅      |
| NEXT_PUBLIC_API_URL          | Deployment config                     | Frontend API calls                                           | URL                                  | ❌      | ✅       | ✅      |
| NEXT_PUBLIC_APP_URL          | Deployment config                     | Frontend self-reference URL                                  | URL                                  | ❌      | ✅       | ✅      |
| NEXT_PUBLIC_SITE_URL         | Deployment config                     | Website self-reference URL                                   | URL                                  | ❌      | ✅       | ✅      |
| NEXT_PUBLIC_POSTHOG_HOST     | PostHog configuration                 | Analytics host URL                                           | URL                                  | ❌      | ✅       | ❌      |
| NEXT_PUBLIC_POSTHOG_KEY      | PostHog project settings              | Analytics project key                                        | String                               | ❌      | ✅       | ❌      |
| NEXT_PUBLIC_GA_MEASUREMENT_ID| Google Analytics settings             | Website traffic tracking                                     | String starting with `G-`             | ❌      | ❌       | ✅      |
| NEXT_PUBLIC_SUPABASE_ANON_KEY| Supabase API settings                 | Client-side auth/database access                             | String starting with `eyJ`            | ❌      | ✅       | ❌      |
| NEXT_PUBLIC_SUPABASE_URL     | Supabase settings                     | Supabase URL for client                                      | URL                                  | ❌      | ✅       | ❌      |
