FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


COPY . .


RUN pip install --no-cache-dir pytest


RUN pytest --disable-warnings


EXPOSE 8080


CMD ["python", "app.py"]
