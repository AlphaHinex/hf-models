# Download a single file
from huggingface_hub import hf_hub_download
hf_hub_download(repo_id="bigcode/starcoderbase-3b", filename="config.json")

# Or an entire repository
# from huggingface_hub import snapshot_download
# snapshot_download("tiiuae/falcon-7b-instruct", cache_dir="/home/runner/work/hf-models/hf-models")