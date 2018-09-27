# Git Archive

Make a tarball out of a GitHub repo over SSH.

## Why?

GitHub doesn't support `git archive --remote`, and while you can get a tarball of a pulic repo from a URL, getting one for a private repo requires api tokens.

I just needed a way to make a tarball of a git repo in a containerized build workflow... so this fills that need.

## Usage

Expects a repository as an command argument, ie.

```
git@github.com:docker/docker-ce.git
```

Because of some internal implementation details, `.git` at is assumed to be in the input.

```
docker run --rm -it -v $PWD/tmp:/output nbering/git-archive git@github.com:docker/docker-ce.git
```

- `--rm` - auto-remove container after exit
- `-it` - attach to the terminal as an interactive session (helpful if there's any prompts)
- `-v $PWD/tmp:/output` - `/output` inside the container is where the archive will be placed. This mounts `./tmp` to that directory to capture the output.
- `nbering/git-archive` - The image name.
- `git@github.com:docker/docker-ce.git` - The repo to capture as an archive. Must end in `.git`.

Since this is more-or-less assumed to be for private github repos that you have an SSH key for... mount an SSH key into the container with:

```
-v $HOME/.ssh/github_rsa:/root/.ssh/id_rsa:ro
```

This would produce a tarball of the docker-ce repo at `./tmp/docker-ce.tar.gz`.
