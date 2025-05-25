# serve-models
A FastAPI script to serve models on Cloud Run

## Running with Docker

To build and run this application using Docker:

1.  **Build the Docker image:**
    ```bash
    docker build -t fastapi-app .
    ```

2.  **Run the Docker container:**
    ```bash
    docker run -p 8000:8000 -e PORT=8000 fastapi-app
    ```
    The application will be accessible at `http://localhost:8000`.

## Deployment to Google Cloud Run

This application is configured to be deployed to Google Cloud Run.

1.  Ensure you have the Google Cloud SDK installed and configured.
2.  Build the image and submit it to Google Cloud Build (which can also push to Google Container Registry or Artifact Registry):
    ```bash
    gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/fastapi-app
    ```
    Replace `YOUR_PROJECT_ID` with your actual Google Cloud project ID.
3.  Deploy the image to Cloud Run:
    ```bash
    gcloud run deploy fastapi-app-service \
        --image gcr.io/YOUR_PROJECT_ID/fastapi-app \
        --platform managed \
        --region YOUR_REGION \
        --allow-unauthenticated
    ```
    Replace `YOUR_PROJECT_ID` and `YOUR_REGION` with your appropriate values. The `--allow-unauthenticated` flag makes the service publicly accessible; adjust as needed for your security requirements.
