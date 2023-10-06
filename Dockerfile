FROM python:3-alpine

ARG HF_TOKEN
ARG HUGGINGFACE_HUB_CACHE

RUN pip install huggingface_hub
RUN huggingface-cli login --token $HF_TOKEN

COPY download.py .
RUN python download.py