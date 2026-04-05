# (Build Stage)
FROM python:3.9-alpine AS builder

# Necessary dependencies for Alpine
RUN apk add --no-cache gcc musl-dev libffi-dev

WORKDIR /app

RUN pip install --no-cache-dir --upgrade pip setuptools wheel

COPY app/requirements.txt .
RUN pip install --no-cache-dir --target=/app/deps -r requirements.txt

# (Runtime Stage)
FROM python:3.9-alpine

WORKDIR /app

RUN apk upgrade --no-cache

RUN addgroup -S appuser && adduser -S appuser -G appuser

COPY --from=builder /app/deps /usr/local/lib/python3.9/site-packages
COPY app/main.py .

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

CMD ["python", "main.py"]