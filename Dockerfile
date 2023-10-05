FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        openssh-client 

ENV WD /usr/local/x
ENV URL https://huggingface.co/bigcode/starcoderbase-1b 

WORKDIR $WD

RUN git lfs install
RUN git clone $URL
