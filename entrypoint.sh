#!/bin/bash
set -ex

export INPUT_CHARTS_FOLDER=${INPUT_CHARTS_FOLDER:-.}

if [ -z "${INPUT_CHART_NAME}" ]; then
  echo "chart_name is not set"
  exit 1
fi

if [ -z "${INPUT_REGISTRY_HOST}" ]; then
  echo "registry_host is not set"
  exit 1
fi

if [ -z "${INPUT_REPOSITORY_PATH}" ]; then
  echo "repository_path is not set"
  exit 1
fi

if [ -z "${INPUT_REPOSITORY_USER}" ]; then
  echo "repository_user is not set"
  exit 1
fi

if [ -z "${INPUT_REPOSITORY_PASSWORD}" ]; then
  echo "repository_password is not set"
  exit 1
fi

if [ -z "${INPUT_CHART_VERSION}" ]; then
  echo "chart_version is not set"
  exit 1
fi

if [ -z "${INPUT_APP_VERSION}" ]; then
  echo "app_version is not set"
  exit 1
fi

INPUT_CHART_VERSION=$(echo "${INPUT_CHART_VERSION}" | sed -e 's|refs/tags||' | sed -e 's/^v//')
INPUT_APP_VERSION=$(echo "${INPUT_APP_VERSION}" | sed -e 's|refs/tags||' | sed -e 's/^v//' | sed -e 's/+.*//')

cd "${INPUT_CHARTS_FOLDER}"

helm inspect chart "${INPUT_CHART_NAME}"
helm package --app-version "${INPUT_APP_VERSION}" --version "${INPUT_CHART_VERSION}" "${INPUT_CHART_NAME}"
echo "${INPUT_REPOSITORY_PASSWORD}" | helm registry login -u "${INPUT_REPOSITORY_USER}" --password-stdin "${INPUT_REGISTRY_HOST}"
helm push "${INPUT_CHART_NAME}-${INPUT_CHART_VERSION}.tgz" "oci://${INPUT_REGISTRY_HOST}/${INPUT_REPOSITORY_PATH}"
