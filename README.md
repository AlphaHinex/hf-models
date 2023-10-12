README
======

```bash
$ docker pull alphahinex/hf-models:test
$ docker run --name test --rm alphahinex/hf-models:test tail -f /dev/null
```

```bash
$ docker exec -ti test sh
/ # tree /root/.cache/huggingface/hub
/root/.cache/huggingface/hub
└── models--tiiuae--falcon-7b-instruct
    ├── blobs
    │   └── 84d8843072cbc300692c6bccff5b9c08c430498e
    ├── refs
    │   └── main
    └── snapshots
        └── cf4b3c42ce2fdfe24f753f0f0d179202fea59c99
            └── config.json -> ../../blobs/84d8843072cbc300692c6bccff5b9c08c430498e
```

```bash
$ docker cp -L test:/root/.cache/huggingface/hub/models--tiiuae--falcon-7b-instruct/snapshots/cf4b3c42ce2fdfe24f753f0f0d179202fea59c99/config.json .
```

```bash
$ docker rm -f test
```