3) Run with one line
From your project root:

bash
Copy
Edit
# Use .env.local, .env.staging, or default to .env.production
ENV_FILE=.env.local docker-compose up --build
If you want staging:

bash
Copy
Edit
ENV_FILE=.env.staging docker-compose up --build
If you omit ENV_FILE, it’ll pick .env.production by default:

bash
Copy
Edit
docker-compose up --build