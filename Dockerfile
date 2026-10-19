# Docker image for the DevOps student application — Ruslan Omargali
# 1. Base image: small Linux (Alpine) with Python 3 installed
FROM python:3.12-alpine

LABEL maintainer="Ruslan Omargali" \
      group="IT2-2309" \
      student_id="37858"

# 2. Working directory inside the image; next commands run from here
WORKDIR /app

# 3. Copy the application from the project into the image
COPY app/ /app/

# 4. Create an unprivileged user and make the app executable
RUN adduser -D appuser && chmod 755 /app/app.py

USER appuser

# Default values; can be overridden with `docker run -e ...`
ENV APP_PORT=8000 \
    PYTHONUNBUFFERED=1

# 5. Document the port the application listens on
EXPOSE 8000

# Docker checks that the application answers on /health
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD wget -qO- http://localhost:8000/health || exit 1

# 6. Command executed when a container starts
CMD ["python", "app.py"]
