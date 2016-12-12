# PulseBridge Prompt

> A spectacular (BaSH) prompt for *nix distributions. (Only tested on macOS currently)

## Vitals

Info          | Badges
--------------|--------------
License       | [![License][license-image]][license]
Chat          | [![Join Chat][gitter-image]][gitter-url]
Discord       | [![Join Voice][discord-image]][discord-url]

## Getting Started

### What is PulseBridge Prompt?

PulseBridge Prompt is a prompt for BaSH on *nix distributions that includes a ton of useful functionality, including:

* Two-line prompt that includes username, hostname, and current path
* Git prompt support (emit information about the current branch and status when in a git path)
* Editor launch support, including Visual Studio Code and Sublime Text
* BaSH completion for git and git-flow
* Install dotnet-cli
* Bookmarking support (cdable variables)
* Flush DNS
* Enable and disable hidden files in Finder (OS X)
* Show available colors (already set as variables for use elsewhere)
* ... and much more.

Note: All "extensions" are implemented as sourced function calls, so it should not interfere with existing
customization (aside from the prompt).

### Using PulseBridge Prompt

Installing PulseBridge Prompt is a 1 step process:

``` bash
curl -L https://raw.github.com/pulsebridge/prompt/master/bootstrap.sh | /usr/bin/env bash
```

(Optional) Open the included Monokai theme (currently only supported on OS X):

``` bash
themes
```

**NOTE**: The installer simply creates a new folder (.pulsebridge) under the home folder, and copies all of the files
there. It will backup this folder to ./backup first. It wires up the "extensions" by adding a source command for
$HOME/.pulsebridge/prompt/bashrc to $HOME/.bash_profile. It will not duplicate itself, so you can re-run the installer
to upgrade at any time. The $HOME/.bash_profile is also backed up to ./backup/[date]/.bash_profile.

## Copright and License

&copy; PulseBridge, Inc. and contributors. Distributed under the MIT license. See [LICENSE][] for details.

[license-image]: https://img.shields.io/badge/license-MIT-blue.svg
[license]: LICENSE

[gitter-url]: //gitter.im/pulsebridge/prompt
[gitter-image]:https://img.shields.io/badge/⊪%20gitter-join%20chat%20→-1dce73.svg

[discord-image]:https://img.shields.io/badge/discord-online-blue.svg
[discord-url]:https://discord.gg/PrQmKTa