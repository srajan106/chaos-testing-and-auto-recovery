FROM python:3.11-slim

# Prevent Python from writing .pyc files and enable logging immediately
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies (optional but useful)
RUN apt-get update && apt-get install -y \
    gcc curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies separately (better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Create required directories
RUN mkdir -p logs backups

# Expose port
EXPOSE 5000

# Healthcheck (VERY IMPORTANT for auto-recovery)
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
CMD curl -f http://localhost:5000/health || exit 1

# Run app
CMD ["python", "app.py"]