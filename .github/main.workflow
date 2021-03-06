workflow "Build container, tag it, and push to Docker Hub" {
  on = "push"
  resolves = ["Build container", "Log into Docker Hub", "Tag toolchain container", "Push to Docker Hub"]
}

action "Log into Docker Hub" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Build container" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Log into Docker Hub"]
  args = "build -t docker-version-tag ."
}

action "Tag toolchain container" {
  uses = "actions/docker/tag@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Build container"]
  args = "docker-version-tag rrbutani/docker-version-tag"
}

action "Tag toolchain container with version" {
  uses = "./"
  needs = ["Build container"]
  args = "docker-version-tag rrbutani/docker-version-tag"
}

action "Push to Docker Hub" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Tag toolchain container", "Tag toolchain container with version"]
  args = "push rrbutani/docker-version-tag"
}
