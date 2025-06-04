from fastapi import FastAPI
from typing import List
from pydantic import BaseModel
from transformers import pipeline
import uvicorn
import os

app = FastAPI()

classifier = pipeline("zero-shot-classification", model="/app/model/facebook/bart-large-mnli", tokenizer="/app/model/facebook/bart-large-mnli")

class BART_Large_MNLI(BaseModel):
    text: str
    candidate_labels: List[str]

@app.get("/")
def root():
    return {"message": "Server Running"}

@app.post("/facebook-bart-large-mnli")
def bart_large_mnli(instance: BART_Large_MNLI) -> dict:
    result = classifier(instance.text, instance.candidate_labels)
    return result

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    uvicorn.run(app, host="0.0.0.0", port=port)
