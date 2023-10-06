FROM python:3-alpine

ENV HF_TOKEN

RUN pip install huggingface_hub
RUN huggingface-cli login --token $HF_TOKEN

COPY download.py .
RUN python download.py