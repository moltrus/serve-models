FROM python:3.9-slim-buster

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/model && \
    python -c "from transformers import AutoModelForSequenceClassification, AutoTokenizer; \
               AutoModelForSequenceClassification.from_pretrained('facebook/bart-large-mnli', cache_dir='/app/model'); \
               AutoTokenizer.from_pretrained('facebook/bart-large-mnli', cache_dir='/app/model')"

RUN python -c "from transformers import pipeline; \
               classifier = pipeline('zero-shot-classification', model='/app/model/facebook/bart-large-mnli', \
               tokenizer='/app/model/facebook/bart-large-mnli')"

COPY main.py .

ENV PORT 8080
EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
