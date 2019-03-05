#!/bin/sh

echo hi

IMAGE_NAME="${1}"
IMAGE_TAG_NAME="${2}"
DOCKERFILE="${3-Dockerfile}"

# At least two args or bust:
[ ${#} -lt 2 ] && exit 1

# Let's get the version:
ver=

extract_version () { echo "${@}" | head -1 | cut -d= -f2 | cut -d' ' -f1 | tr -d '"'; }
look_for_string () { grep -i "${@}" "${DOCKERFILE}"; }

try () { s="$(look_for_string "${@}")" && ver=$(extract_version "${s}"); }

try "^ARG VERSION" ||
try "^ENV VERSION" ||
try "^LABEL version" ||
try '^LABEL "version"' ||
exit 78

echo "${IMAGE_NAME} -> ${IMAGE_TAG_NAME}:${ver}"
docker tag ${IMAGE_NAME} "${IMAGE_TAG_NAME}:${ver}" && exit 0
