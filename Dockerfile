FROM docker:stable

LABEL "com.github.actions.name"="Docker Version Tag Action"
LABEL "com.github.actions.description"="Tag docker images with their version given a Dockerfile"
LABEL "com.github.actions.icon"="hash"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/rrbutani/docker-version-tag"
LABEL "homepage"="https://github.com/rrbutani/docker-version-tag"
LABEL "maintainer"="Rahul Butani <rrbutani@users.noreply.github.com>"

LABEL "version"="0.2.0"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
