# promptMastermind

> A spectacular shell prompt for macOS and *nix distributions

![Preview][preview-image]

## Vitals

| Info     | Badges                                                      |
| -------- | ----------------------------------------------------------- |
| License  | [![License][license-image]][license-url]                    |
| Build    | [![build][workflow-image]][workflow-url]                    |
| Releases | ![stable][stable-version-image] ![next][next-version-image] |

### Operating Systems

While prompt *should* run on macOS High Sierra or greater and all Linux distributions with either apt-get or yum, we
only validate a few of the most popular.

| Name   | Version                                                              |
| ------ | -------------------------------------------------------------------- |
| macOS  | 10.15 (Catalina) and 11.0 (Big Sur)                                  |
| ubuntu | 16.04 (Xenial Xerus), 18.04 (Bionic Beaver), and 20.04 (Focal Fossa) |
| fedora | 32 and 33                                                            |
| debian | 9 (Stretch) and 10 (Buster)                                          |
| centOS | 8                                                                    |
| mint   | 18 (Sarah), 19 (Tara), and 20 (Ulyana)                               |

> NOTE: not all capabilities are tested. If you discover any bugs or wish to add your favourite distro to the validated
> list, please [create an issue][new-issue-url].

## Know It

promptMastermind is a prompt for sh, bash, and zsh on *nix distributions that includes a ton of useful functionality,
including:

* A two-line prompt that displays username, hostname, and current path
* Git prompt support (that emits information about the current branch and status when in a git path)
* Better tab completion for git and git-flow
* Installation of dotnet sdk, aws sdk, and gcloud sdk
* Bookmarking support (cdable variables)
* Variables support (add vars without modifying profile)
* Flush DNS (on macOS)
* Ability to enable and disable hidden files in Finder (on macOS)
* Display of available colors (already set as variables for use elsewhere)
* Display currently active Python virtialenv when using [pyenv][pyenv-url] & [direnv][direnv-url] (bash & zsh)
* ... and much more!

Note: All "extensions" are implemented as scripts added to the path, so it should not interfere with existing
customization (aside from the prompt).

## Use It

Install promptMastermind in one step (choose one of the following options):

``` sh
# install and use bash
curl -fsSL https://git.io/am-prompt | sh -s -- bash

# install and use zsh
curl -fsSL https://git.io/am-prompt | sh -s -- zsh
```

> NOTE: if you do not specify a shell, bash will be used by default

### Specific Versions

Although it is **NOT** recommended, you can install a specific version of prompt using one of the following:

``` sh
# install and use bash with prompt v7.0.0
curl -fsSL https://git.io/am-prompt | sh -s -- --version v7.0.0 bash

# install and use zsh with prompt v8.0.0
curl -fsSL https://git.io/am-prompt | sh -s -- --version v8.0.0 zsh
```

All available versions of prompt are available here: <https://github.com/automotiveMastermind/prompt/releases>

> NOTE: zsh is only available as of v7.0.0 -- older versions of prompt only support bash

(Optional) Open an included theme (currently only supported on macOS):

``` sh
theme monokai # general high quality theme that has been around for many years
```

OR

```sh
theme dark-mode # our own custom theme that is nice and bright for dark mode on macOS
```

Updating promptMastermind:

``` sh
update-prompt
```

If you already have the latest version of prompt installed, the `update-prompt` command will not re-install the
current version.

**NOTE**: The installer simply creates a new folder (.am) under the home folder and copies all of the files
there. It will backup this folder first. It wires up the "extensions" by adding a source command for
`$HOME/.am/prompt/bashrc` to `$HOME/.bash_profile`. It will not duplicate itself, so you can re-run the
installer or use the `upgrade-prompt` command to upgrade at any time.

The backup folder is located at: `$HOME/.am/backup/prompt/[date]`.

All profile and rc scripts such as `$HOME/.bash_profile` are also backed up to `$HOME/.am/backup/prompt/[date]/`.

## Build It

In order to test the installation routine for promptMastermind, we use a set of docker images for each of the supported
*nix platforms. The build script in the `docker/` folder can be used to build all of the images, or specific ones:

```sh
# build all of the platforms (this will take a while)
./docker/build.sh

# build the debian and ubuntu platforms
./docker/build.sh debian ubuntu

# build just the mint platform
./docker/build.sh mint
```

## Features

### Two-Line Prompt

The first-line displays username, hostname, and current path.

The second-line emits information about the current branch and status when in a git path. If using [pyenv][pyenv-url] and [direnv][direnv-url] the second-line also displays the currently activated Python virtualenv.

### SDK Installs

[AWS SDK][aws-sdk-url]

```sh
install-aws
```

[Google Cloud SDK][gcloud-sdk-url]

```sh
install-gcloud
```

[.Net SDK][dotnet-sdk-url]

```sh
install-dotnet
```

### Colors

Global colors defined by promotMastermind:

| Name               | Color                   |
| ------------------ | ----------------------- |
| CLR_CLEAR          | DEFAULT COLOR           |
| CLR_BLACK          | ANSI BLACK (GRAY)       |
| CLR_RED            | ANSI RED                |
| CLR_GREEN          | ANSI GREEN              |
| CLR_YELLOW         | ANSI YELLOW             |
| CLR_BLUE           | ANSI BLUE               |
| CLR_MAGENTA        | ANSI MAGENTA (PURPLE)   |
| CLR_CYAN           | ANSI CYAN               |
| CLR_WHITE          | ANSI WHITE              |
| CLR_BRIGHT_BLACK   | BRIGHT BLACK (GRAY)     |
| CLR_BRIGHT_RED     | BRIGHT RED              |
| CLR_BRIGHT_GREEN   | BRIGHT GREEN            |
| CLR_BRIGHT_YELLOW  | BRIGHT YELLOW           |
| CLR_BRIGHT_BLUE    | BRIGHT BLUE             |
| CLR_BRIGHT_MAGENTA | BRIGHT MAGENTA (PURPLE) |
| CLR_BRIGHT_CYAN    | BRIGHT CYAN             |
| CLR_BRIGHT_WHITE   | BRIGHT WHITE            |

### macOS Commands

Show/Hide Files:

```sh
# show all hidden files
show-all

# hide all hidden files
hide-all
```

Flush DNS:

```sh
flush-dns
```

Set Theme to Monokai:

```sh
theme monokai # general high quality theme that has been around for many years
```

Set Theme to Dark Mode

```sh
theme dark-mode # our own custom theme that is nice and bright for dark mode on macOS
```

[Pandoc][pandoc-url]

```sh
install-pandoc
```

### *nix Commands

[Kubernetes in Docker (Kind)][kind-url]

```sh
install-kind
```

[Minkube][minikube-url]

```sh
install-minikube
```

## Copyright and License

&copy; automotiveMastermind and contributors. Distributed under the MIT license. See [LICENSE][license-url] for details.

[license-image]: https://img.shields.io/badge/license-MIT-blue.svg
[license-url]: LICENSE

[preview-image]: https://user-images.githubusercontent.com/1803684/60201230-a8241300-97fc-11e9-8cb6-613cd31d914f.png

[pyenv-url]: https://github.com/pyenv/pyenv
[direnv-url]: https://github.com/direnv/direnv/wiki/Python
[kind-url]: https://kind.sigs.k8s.io
[aws-sdk-url]: https://github.com/aws/aws-cli
[gcloud-sdk-url]: https://cloud.google.com/sdk/install
[dotnet-sdk-url]: https://github.com/dotnet/installer
[minikube-url]: https://minikube.sigs.k8s.io/docs/start/
[pandoc-url]: https://pandoc.org

[workflow-url]: https://github.com/automotivemastermind/prompt/actions?query=workflow%3Aend-to-end
[workflow-image]: https://img.shields.io/github/workflow/status/automotivemastermind/prompt/end-to-end

[stable-version-image]: https://img.shields.io/github/v/release/automotivemastermind/prompt?label=stable&sort=semver
[next-version-image]: https://img.shields.io/github/v/tag/automotivemastermind/prompt?color=orange&include_prereleases&label=next&sort=semver

[new-issue-url]: https://github.com/automotivemastermind/prompt/issues/new
