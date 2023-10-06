# Download a single file
from huggingface_hub import hf_hub_download
hf_hub_download(repo_id="tiiuae/falcon-7b-instruct", filename="config.json", cache_dir="/home/runner/work/hf-models/hf-models")

# Or an entire repository
# from huggingface_hub import snapshot_download
# snapshot_download("bigcode/starcoderbase-3b", cache_dir="/home/runner/work/hf-models/hf-models")