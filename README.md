# Docker Image for the Helm Release Github Action

This is the actual implementation of the
[Flownative GitHub Action for releasing Helm charts](https://github.com/flownative/action-helm-release).
The actual GitHub action refers to a pre-built image in its
`Dockerfile`, so that the action image does not have to be re-built on
every use.
