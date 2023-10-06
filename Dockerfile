FROM python:3-alpine

ARG HF_TOKEN

RUN pip install huggingface_hub
RUN huggingface-cli login --token $HF_TOKEN

COPY download.py .
RUN python download.py
RUN rm -f /root/.cache/huggingface/token