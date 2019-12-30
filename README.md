# docker_amazonlinux

Amazonlinux docker image with awscli, awscli2, saml2aws
- mounts ~/.saml2aws, ~/.aws from the host
- mounts .bash_history

## macOS requirements

```shell
brew cask install docker
```

## Build and run

```shell
./bin/build.sh
./bin/run.sh
```

## Reference:

- https://docs.aws.amazon.com/cli/latest/userguide/install-linux-al2017.html
- https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux-mac.html
- https://github.com/Versent/saml2aws#usage