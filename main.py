from fastapi import FastAPI
from typing import List
from pydantic import BaseModel
from transformers import pipeline

app = FastAPI()

class BART_Large_MNLI(BaseModel):
   text: str
   candidate_labels: List[str] = []

@app.get("/")
async def root():
   return {"message": "Server Running"}

@app.post("facebook-bart-large-mnli")
async def bart_large_mnli(instance: BART_Large_MNLI) -> dict:
   classifier = pipeline("zero-shot-classification", model="facebook/bart-large-mnli")
   result = classifier(instance.text, instance.candidate_labels)
   return result
