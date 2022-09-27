# Yocto Build Environment as Docker Container

This repository aims to provide a complete Yocto build environment for building
BISDN Linux in a docker container.

## Build Environment

The build environment is based on the recommendations documented in the Yocto
project for Ubuntu and Debian
[here](https://docs.yoctoproject.org/3.1.7/ref-manual/ref-system-requirements.html#ubuntu-and-debian).
In addition to the packages mentioned there, it also includes
[libelf](https://directory.fsf.org/wiki/Libelf) with development headers and
[PyYAML](https://pyyaml.org), since those are needed to build some of the
packages included in BISDN Linux.
Last but not least, the environment also includes
['repo'](https://android.googlesource.com/tools/repo), a tool developed by google
to manage multiple git repositories and their respective versions from one
manifest file. Since 'repo' requires python and building Open Network Linux
depends on python2, the environment includes both python3, as well as python2.

In addition to providing all packages and dependencies needed for building BISDN
Linux with the Yocto build chain, the environment already includes a
minimalistic [.gitconfig](./gitconfig) needed when using the aforementioned
'repo' tool and sets the locale to 'en_US.UTF-8'. Since the Yocto build tool
'bitbake' does not allow building as 'root' user, the environment includes a
'builder' user, which is used by default when running the 'ci' version of the
container.  All details on how the container is built and which packages are
included can be found directly in the [Dockerfile](./Dockerfile) included in
this repository.

The Dockerfile used to build the environment described above is written as a
[multi-stage build file](https://docs.docker.com/build/building/multi-stage/)
and includes the two targets 'base' and 'ci'. The only difference between these
two targets is the `USER` which the container will use to run all commands by
default. The 'ci' target is intended to be ready to use for any pipelines, since
it automatically runs all commands as `builder` user and therefore allows to
directly get started with 'bitbake'. The 'base' target on the other hand will by
default execute everything as 'root' and is intended to allow easier
modification during runtime (like installing more packages or changing and
adding users).

## GitHub workflows

This project uses
[GitHub workflows](https://docs.github.com/en/actions/using-workflows/about-workflows)
to automatically build the aforementioned environment as a container. All
containers are then published as
[GitHub Packages](https://github.com/orgs/bisdn/packages?repo_name=docker-yocto-builder).
To ensure consistent code quality in all files in this repository, the
[GitHub Super-Linter](https://github.com/github/super-linter) is run on every
pull request for all files changed.
In addition to that, all commits are required to follow the
[conventional commit format](https://www.conventionalcommits.org) and an
automated commit linter for this format is run on every pull request.
For detailed information on all workflows, please refer to the workflow files
included in the [.github/workflows/](./.github/workflows/) folder in this
repository.

## Contributing

If you feel like contributing to this project, please use any of the GitHub
tools available and choose whatever fits your contribution best. We welcome pull
requests as well as bug reports and feature request in form of issues. If you
want to contribute in any other way or style, please open an issue and let us
know.
All code contributions are understood to be given and handled under the [MIT
License](./LICENSE) covering the project, unless explicitly stated otherwise.
To open a pull request, please fork this repository and always base you changes
on top of the 'main' branch. If you change the behaviour or way how this project
works, please do not forget to also update the documentation related to this in
the README.
As already mentioned in the section [GitHub workflows](#github-workflows), we
use the [GitHub Super-Linter](https://github.com/github/super-linter) to lint
all code and require all commit messages to follow the
[conventional commit format](https://www.conventionalcommits.org). Please make
sure your pull request passes the automated tests.
If you need help while figuring out how to contribute or our linting pipelines
are giving you too much unnecessary trouble, please feel free to ask one of our
maintainers listed in the [Maintainer](#maintainers) section directly.

## Maintainers

Jan Klare: <jan.klare@bisdn.de>

## License

All code within this repository is licensed under the MIT License, unless
explicitly stated otherwise. A copy of the license can be found in the
[LICENSE](./LICENSE) file included.
