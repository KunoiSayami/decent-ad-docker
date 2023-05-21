# Decent Ad dockerfile

A helper project for etaoin/decentad

## Build

```
docker buildx build --build-arg "REMOTE_ADDRESS=$REMOTE_ADDRESS" . -t decentad_base
docker buildx build -f dockerfile_task . -t decentad
```

If you want to rebuild, run second command with `--no-cache` arguments.
