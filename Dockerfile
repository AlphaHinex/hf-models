FROM python:3-alpine

COPY TONEK_FILE TONEK_FILE
RUN pip install huggingface_hub
RUN huggingface-cli login --token | cat TONEK_FILE

COPY download.py .
RUN python download.py
RUN rm -f /root/.cache/huggingface/token && rm -f TONEK_FILE
