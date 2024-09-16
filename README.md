# Docker Image for the Helm Release GitHub Action

This is the actual implementation of the
[Flownative GitHub Action for releasing Helm charts](https://github.com/flownative/action-helm-release).
The actual GitHub action refers to a pre-built image in its
`Dockerfile`, so that the action image does not have to be re-built on
every use.

## Testing

To test this action locally, build the image and run the container as follows:

```shell
docker buildx build --platform linux/amd64 \
  --tag flownative/action-helm-release:dev --load .

docker run --name workflow --rm \
  -e INPUT_APP_VERSION=2.133.1+5 
  -e INPUT_CHART_VERSION=2.133.1+5 \
  -e INPUT_REGISTRY_HOST=dev.harbor.example.com \
  -e INPUT_REPOSITORY_PATH=acme-charts \
  -e INPUT_CHART_NAME=beach-my-app \
  -e INPUT_CHARTS_FOLDER=/application/Helm \
  -e INPUT_REPOSITORY_USER=robot#acme-charts+github-test \
  -e INPUT_REPOSITORY_PASSWORD=… \
  -v=$(pwd):/application docker.io/flownative/action-helm-release:dev
```
