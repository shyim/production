#!/usr/bin/env bash

CWD="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

set -e

export PROJECT_ROOT="${PROJECT_ROOT:-"$(dirname "$CWD")"}"
ADMIN_ROOT="${ADMIN_ROOT:-"${PROJECT_ROOT}/vendor/shopware/platform/src/Administration"}"

# build admin
[[ ${CI} ]] || "${CWD}/ci" bundle:dump
(cd "${ADMIN_ROOT}"/Resources/app/administration && npm clean-install && npm run build)
[[ ${CI} ]] || "${CWD}/ci" asset:install
