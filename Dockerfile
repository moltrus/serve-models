FROM python:3.9-slim-buster

RUN apt-get update && apt-get install -y git && apt-get clean

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN python -c "\
from transformers import AutoTokenizer, AutoModelForSequenceClassification; \
AutoModelForSequenceClassification.from_pretrained('facebook/bart-large-mnli', cache_dir='/app/model'); \
AutoTokenizer.from_pretrained('facebook/bart-large-mnli', cache_dir='/app/model')"

COPY main.py .

ENV PORT 8080
EXPOSE 8080

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080" ]
