#!/bin/sh

echo hi

set -x

IMAGE_NAME="${1}"
IMAGE_TAG_NAME="${2}"
DOCKERFILE="${3}"

# Three args or bust:
[ ${#} -ne 3 ] && exit 1

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

docker tag ${IMAGE_NAME} "${IMAGE_TAG_NAME}:${ver}" && exit 0
