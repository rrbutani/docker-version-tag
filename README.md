# GitHub Action for Docker Version Tag

Quick and dirty GitHub Action that tags a specified image with it's `version` label, given a Dockerfile for that image.

The [Docker Tag action](https://github.com/actions/docker/tree/master/tag) is supposed to do this (and more!) without needing to be given a Dockerfile but it seems to run into trouble when running `docker inspect` (not allowed on GitHub Actions, I think). Until that action is fixed, this action provides a workaround.

## Usage

This action takes three arguments: the image to be tagged (must already be built), the image name (without tags), and the Dockerfile for the image. For example:

```
action "version-tag" {
    uses = "rrbutani/docker-version-tag@master"
    args = "base octocat/base env/Dockerfile"
}
```

This action will look for, in order (not case sensitive):
 - `ARG VERSION`
 - `ENV VERSION`
 - `LABEL version`
 - `LABEL "version"`

The first of these that are found will be used to tag the image. This action doesn't check to make sure that the version found is valid semver.

If none of the above are found, the image isn't tagged and the action returns a neutral status code (78).
