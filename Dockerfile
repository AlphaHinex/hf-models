FROM bitnami/git

ENV WD /usr/local/x
ENV URL https://huggingface.co/bigcode/starcoderbase-1b 

WORKDIR $WD

RUN git lfs install
RUN git clone $URL