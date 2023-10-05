FROM bitnami/git

ENV WD /usr/local/x
ENV URL https://huggingface.co/Salesforce/codegen-350M-mono

WORKDIR $WD

RUN git lfs install
RUN git clone $URL