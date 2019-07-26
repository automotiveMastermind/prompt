# promptMastermind

> A spectacular (BaSH) prompt for macOS and *nix distributions

![Preview][preview-image]

## Vitals

Info          | Badges
--------------|-------------------------------------
License       | [![License][license-image]][license-uri]
License Scan  | [![FOSSA Status][fossa-image]][fossa-uri]
Build         | [![Build][build-image]][build-uri]

### Supported Operating Systems

Name   | Version
-------|------------------
macOS  | Sierra or greater
ubuntu | 16.04 or greater
fedora | 29 or greater
debian | 9 or greater
centOS | 7 or greater
mint   | 19 or greater

## Know It

promptMastermind is a prompt for BaSH on *nix distributions that includes a ton of useful functionality, including:

* A two-line prompt that displays username, hostname, and current path
* Git prompt support (that emits information about the current branch and status when in a git path)
* Better BaSH completion for git and git-flow
* Installation of dotnet-cli
* Bookmarking support (cdable variables)
* Variables support (add vars without modifying profile)
* Flush DNS (on macOS)
* Ability to enable and disable hidden files in Finder (on macOS)
* Display of available colors (already set as variables for use elsewhere)
* ... and much more!

Note: All "extensions" are implemented as sourced function calls, so it should not interfere with existing
customization (aside from the prompt).

### Use It

Install promptMastermind in one step:

``` bash
curl -fsSL https://git.io/am-prompt | /usr/bin/env bash
```

(Optional) Open the included Monokai theme (currently only supported on macOS):

``` bash
theme
```

Updating promptMastermind:

``` bash
update-prompt
```

If you already have the latest version of prompt installed, the ```update-prompt``` command will not re-install the
current version.

**NOTE**: The installer simply creates a new folder (.am) under the home folder and copies all of the files
there. It will backup this folder first. It wires up the "extensions" by adding a source command for
```$HOME/.am/prompt/bashrc``` to ```$HOME/.bash_profile```. It will not duplicate itself, so you can re-run the
installer or use the ```upgrade-prompt``` command to upgrade at any time.

The backup folder is located at: ```$HOME/.am/prompt/backup/[date]```.

The ```$HOME/.bash_profile``` is also backed up to ```$HOME/.am/prompt/backup/[date]/.bash_profile```.

## Build It

In order to test the installation routine for promptMastermind, we use a set of docker images for each of the supported *nix platforms. The build script in the `docker/` folder can be used to build all of the images, or specific ones:

```sh
# build all of the platforms (this will take a while)
./docker/build.sh

# build the debian and ubuntu platforms
./docker/build.sh debian ubuntu

# build just the mint platform
./docker/build.sh mint
```

In addition, [circleci][circleci-uri] is used to build all platforms, including macOS as part of our pull request validation. Special thanks to [circleci][circleci-uri] for providing the build agents!

## Copyright and License

&copy; automotiveMastermind and contributors. Distributed under the MIT license. See [LICENSE][license-uri] for details.

[license-image]: https://img.shields.io/badge/license-MIT-blue.svg
[license-uri]: LICENSE

[build-image]: https://circleci.com/gh/automotiveMastermind/prompt.svg?style=svg
[build-uri]: https://circleci.com/gh/automotiveMastermind/prompt
[circleci-uri]: https://circleci.com

[preview-image]: https://user-images.githubusercontent.com/1803684/60201230-a8241300-97fc-11e9-8cb6-613cd31d914f.png

[fossa-image]: https://app.fossa.com/api/projects/custom%2B12139%2Fgit%40github.com%3AautomotiveMastermind%2Fprompt.git.svg?type=shield
[fossa-uri]: https://app.fossa.com/projects/custom%2B12139%2Fgit%40github.com%3AautomotiveMastermind%2Fprompt.git?ref=badge_shield
