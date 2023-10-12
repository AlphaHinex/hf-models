FROM python:3-alpine

COPY TONEK_FILE TONEK_FILE
RUN pip install huggingface_hub hf_transfer
RUN huggingface-cli login --token | cat TONEK_FILE

COPY download.py .
RUN HF_HUB_ENABLE_HF_TRANSFER=1 python download.py
RUN rm -f /root/.cache/huggingface/token && rm -f TONEK_FILE
