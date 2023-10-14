# Download a single file
# from huggingface_hub import hf_hub_download
# hf_hub_download(repo_id="tiiuae/falcon-7b-instruct", filename="config.json")

# Or an entire repository
from huggingface_hub import snapshot_download
snapshot_download("Salesforce/codegen25-7b-mono")

# See more at https://huggingface.co/docs/huggingface_hub/en/guides/download
