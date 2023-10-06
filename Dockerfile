FROM python:3-alpine

ENV HF_TOKEN=xxx
ENV HUGGINGFACE_HUB_CACHE=xxx

RUN pip install huggingface_hub
RUN huggingface-cli login --token $HF_TOKEN

COPY download.py .
RUN python download.py