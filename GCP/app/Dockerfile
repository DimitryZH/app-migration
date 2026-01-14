FROM python:3.11-slim

# Ensure logs are flushed and no .pyc files are written
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8080

WORKDIR /app

# Install minimal OS dependencies (Pillow, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libjpeg-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY . .

# Cloud Run will set PORT; default to 8080 for local runs
EXPOSE 8080

# Use Gunicorn to serve the Flask app (application:application)
CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:${PORT:-8080} application:application"]

