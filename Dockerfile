FROM python:3-alpine

COPY TONEK_FILE TONEK_FILE
RUN pip install huggingface_hub
RUN cat TONEK_FILE | xargs huggingface-cli login --token

COPY download.py .
RUN HF_HUB_ENABLE_HF_TRANSFER=1 python download.py
RUN rm -f /root/.cache/huggingface/token && rm -f TONEK_FILE
