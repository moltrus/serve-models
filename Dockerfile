# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PORT 8000

# Install system dependencies if any (none specified for now)

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
# Only main.py is needed as Procfile content is in CMD
COPY main.py .

# Make port $PORT available to the world outside this container
EXPOSE ${PORT}

# Run main.py when the container launches using Uvicorn.
# This will respect the PORT environment variable set by Cloud Run.
CMD ["sh", "-c", "uvicorn main:app --host=0.0.0.0 --port=${PORT}"]
