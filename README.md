# Docker Image for the Helm Release Github Action

This is a the actual implementation of the [Flownative Github Action for releasing Helm charts](https://github.com/flownative/action-helm-release).
The actual Github action refers to a pre-built image in its `Dockerfile`, so that the action image does not have to be
re-built on every use.
