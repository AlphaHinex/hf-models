# Download a single file
from huggingface_hub import hf_hub_download
hf_hub_download(repo_id="tiiuae/falcon-7b-instruct", filename="pytorch_model-00002-of-00002.bin")

# Or an entire repository
# from huggingface_hub import snapshot_download
# snapshot_download("tiiuae/falcon-7b-instruct")