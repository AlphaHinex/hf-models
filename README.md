README
======

无法直接从 [HuggingFace](https://huggingface.co/) 下载模型时，可借助此仓库，使用 [GitHub Actions](https://github.com/features/actions) 构建一个 Docker 镜像，在镜像中用 [huggingface_hub](https://github.com/huggingface/huggingface_hub) 下载好所需模型，再将镜像推送至 [Docker Hub](https://hub.docker.com/)，最后以下载镜像方式曲线下载模型。


可用模型（tags）
-------------

当前可用模型可见仓库 [tags](https://github.com/AlphaHinex/hf-models/tags)，仓库 tag 对应镜像 tag，如：

下载 [codet5-small](https://github.com/AlphaHinex/hf-models/releases/tag/codet5-small) tag 对应的镜像命令为：

```bash
docker pull alphahinex/hf-models:codet5-small
```

镜像中包含的模型为 [Salesforce/codet5-small](https://huggingface.co/Salesforce/codet5-small) 。


如何使用
-------

下载镜像：

```bash
docker pull alphahinex/hf-models:codet5-small
```

> 直接从 Docker Hub 下载镜像有困难，可参考 [解决目前Docker Hub国内无法访问方法汇总](https://zhuanlan.zhihu.com/p/642560164) 等方式配置镜像源，实测上海交大镜像站 https://docker.mirrors.sjtug.sjtu.edu.cn/ 速度很快。

启动容器：

```bash
docker run -d --name test --rm alphahinex/hf-models:codet5-small tail -f /dev/null
```

查看模型下载路径：

```bash
$ docker exec -ti test tree /root/.cache/huggingface/hub
/root/.cache/huggingface/hub
└── models--Salesforce--codet5-small
    ├── blobs
    │   ├── 056c085b0bf1966a4658710891af6de209b608be
    │   ├── 263a6f72aceb1716442638a3bcf20afe1eb0de9a
    │   ├── 319fd0bbb49414442ca8c66a675ebce7b3fec747
    │   ├── 38ed64670805e4a3ff4cfa6f764629324a4e3c1e
    │   ├── 51b0295e221a3e91142cfedb6f3d6f9b74291487
    │   ├── 6d34772f5ca361021038b404fb913ec8dc0b1a5a
    │   ├── 968fb0f45e1efc8cf3dd50012d1f82ad82098107cbadde2c0fdd8e61bac02908
    │   ├── 9e26dfeeb6e641a33dae4961196235bdb965b21b
    │   └── e830a2bc8cae841f929043d588e1edcffb28fe9a
    ├── refs
    │   └── main
    └── snapshots
        └── a642dc934e5475185369d09ac07091dfe72a31fc
            ├── README.md -> ../../blobs/51b0295e221a3e91142cfedb6f3d6f9b74291487
            ├── added_tokens.json -> ../../blobs/9e26dfeeb6e641a33dae4961196235bdb965b21b
            ├── config.json -> ../../blobs/056c085b0bf1966a4658710891af6de209b608be
            ├── merges.txt -> ../../blobs/319fd0bbb49414442ca8c66a675ebce7b3fec747
            ├── pytorch_model.bin -> ../../blobs/968fb0f45e1efc8cf3dd50012d1f82ad82098107cbadde2c0fdd8e61bac02908
            ├── special_tokens_map.json -> ../../blobs/e830a2bc8cae841f929043d588e1edcffb28fe9a
            ├── tokenizer_config.json -> ../../blobs/263a6f72aceb1716442638a3bcf20afe1eb0de9a
            └── vocab.json -> ../../blobs/38ed64670805e4a3ff4cfa6f764629324a4e3c1e

5 directories, 18 files
```

从容器中将模型文件拷贝出来：

```bash
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/README.md .
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/added_tokens.json .
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/config.json .
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/merges.txt .
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/pytorch_model.bin .
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/special_tokens_map.json .
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/tokenizer_config.json .
docker cp -L test:/root/.cache/huggingface/hub/models--Salesforce--codet5-small/snapshots/a642dc934e5475185369d09ac07091dfe72a31fc/vocab.json .
```

核验模型文件 SHA256 码（与软链接的文件名一致）：

```bash
$ shasum -a 256 pytorch_model.bin
968fb0f45e1efc8cf3dd50012d1f82ad82098107cbadde2c0fdd8e61bac02908  pytorch_model.bin
```

与 https://huggingface.co/Salesforce/codet5-small/blob/main/pytorch_model.bin 中 SHA256 码一致：

```text
Git LFS Details
SHA256: 968fb0f45e1efc8cf3dd50012d1f82ad82098107cbadde2c0fdd8e61bac02908
Pointer size: 134 Bytes
Size of remote file: 242 MB
```

删除容器：

```bash
$ docker rm -f test
```


如何创建新模型镜像
---------------

1. 修改 [download.py](https://github.com/AlphaHinex/hf-models/blob/main/download.py)，可下载单个文件、文件夹，或按模式过滤要下载的文件，详细用法可见 `huggingface_hub` [Download files](https://huggingface.co/docs/huggingface_hub/en/guides/download)；
1. 修改 `docker-image.yml` [12 行](https://github.com/AlphaHinex/hf-models/blob/main/.github/workflows/docker-image.yml#L12C35-L12C36) 中 `IMAGE_NAME` 变量内的镜像 tag 。

### download.py 示例

1. 下载单个文件
    ```python
    from huggingface_hub import hf_hub_download
    hf_hub_download(repo_id="tiiuae/falcon-7b-instruct", filename="config.json")
    ```
1. 下载整个路径
    ```python
    from huggingface_hub import snapshot_download
    snapshot_download("Salesforce/codegen25-7b-mono")
    ```
1. 包含部分文件
    ```python
    from huggingface_hub import snapshot_download
    snapshot_download("bigcode/starcoder", ignore_patterns=["pytorch_model-00004-of-00007.bin", "pytorch_model-00005-of-00007.bin", "pytorch_model-00006-of-00007.bin"])
    ```
1. 排除部分文件
    ```python
    from huggingface_hub import snapshot_download
    snapshot_download("bigcode/starcoder", allow_patterns=["pytorch_model-00004-of-00007.bin", "pytorch_model-00005-of-00007.bin", "pytorch_model-00006-of-00007.bin"])
    ```

约束
---

目前 Github Actions 使用的 [Runner](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/about-github-hosted-runners#cloud-hosts-used-by-github-hosted-runners) 运行在 [Azure Standard_DS2_v2](https://docs.microsoft.com/azure/virtual-machines/dv2-dsv2-series#dsv2-series) 虚拟机上，有 84GB 数据盘空间挂载在 `/`，14GB 临时存储挂载在 `/mnt`。可供构建任务使用的空闲存储空间在 25~29GB 左右。

在 `docker-image.yml` 中使用 [Maximize build disk space](https://github.com/marketplace/actions/maximize-build-disk-space) 这个 Action 来将根路径的空闲空间扩展到 45GB 左右，如果要下载的模型文件总大小超过了这个范围，可以构建多个镜像，如 [StarCoder 15.5B](https://huggingface.co/bigcode/starcoder) 模型文件总大小在 60GB 以上，可构建 [starcoder-01](https://github.com/AlphaHinex/hf-models/releases/tag/starcoder-01)、[starcoder-02](https://github.com/AlphaHinex/hf-models/releases/tag/starcoder-02) 两个镜像以获得全部文件。