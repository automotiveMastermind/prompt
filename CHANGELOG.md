# Change Log

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

<a name="1.1.0"></a>
# [1.1.0](https://github.com/pulsebridge/prompt/compare/v1.0.2...v1.1.0) (2016-11-14)


### Bug Fixes

* **brew:** correct brew link ([34528d7](https://github.com/pulsebridge/prompt/commit/34528d7))


### Features

* **nvm:** add support for nvm in place of direct node install ([5064c06](https://github.com/pulsebridge/prompt/commit/5064c06))



<a name="1.0.3"></a>
## [1.0.3](https://github.com/pulsebridge/prompt/compare/v1.0.2...v1.0.3) (2016-08-23)



<a name="1.0.0"></a>
# 1.0.0 (2016-08-19)


### Bug Fixes

* **dotnet:** ensure dotnet is on the path ([3dcdfef](https://github.com/pulsebridge/prompt/commit/3dcdfef))
* **dotnet:** fix bad test for presence of dotnet ([bf2b137](https://github.com/pulsebridge/prompt/commit/bf2b137))
* **editors:** install sublime-text3 instead of sublime-text2 ([6b560ba](https://github.com/pulsebridge/prompt/commit/6b560ba))
* **git:** execute git flow init instead of git init in git-extensions ([f4e8db2](https://github.com/pulsebridge/prompt/commit/f4e8db2))
* **git:** set the credential helper to osx keychain on darwin ([c454cb9](https://github.com/pulsebridge/prompt/commit/c454cb9))
* **git:** use brew link overwrite to resolve issue where git did not link if xcode-beta was installed before prompt ([3901fd9](https://github.com/pulsebridge/prompt/commit/3901fd9))
* **install:** fix an issue where the bash_profile could be overwritten ([54bd849](https://github.com/pulsebridge/prompt/commit/54bd849))
* **install:** fix usage order on success function ([caef0da](https://github.com/pulsebridge/prompt/commit/caef0da))
* **install:** remove unnecessary installs; fix git-prompt ([5290719](https://github.com/pulsebridge/prompt/commit/5290719))
* **install:** test for .bash_profile before backing up ([68987fa](https://github.com/pulsebridge/prompt/commit/68987fa))
* **prompt:** fix echo of tests for completion handlers ([4baf9c0](https://github.com/pulsebridge/prompt/commit/4baf9c0))
* **prompt:** use master of posh-git-sh ([1362289](https://github.com/pulsebridge/prompt/commit/1362289))
* **xplat:** add check for darwin for themes ([3b28084](https://github.com/pulsebridge/prompt/commit/3b28084))
* **xplat:** do not emit error messages caused by upgrading latest brew formulae ([a742941](https://github.com/pulsebridge/prompt/commit/a742941))


### Features

* **backup:** retain backups and avoid manipulating .ssh folder ([132af0a](https://github.com/pulsebridge/prompt/commit/132af0a))
* **bookmark:** rename aliases for add/show bookmark ([602c12a](https://github.com/pulsebridge/prompt/commit/602c12a))
* **completion:** add support for bash completion for gulp (if it is globally installed) ([f863b54](https://github.com/pulsebridge/prompt/commit/f863b54))
* **dotnet:** replace dnx/dnvm with dotnet-cli ([bd6b182](https://github.com/pulsebridge/prompt/commit/bd6b182))
* **editors:** use brew cask to install atom, visual studio code, sublime, and textmate (macOS only) ([e15dabc](https://github.com/pulsebridge/prompt/commit/e15dabc))
* **editors:** use built-in cli for vscode, etc ([84d3012](https://github.com/pulsebridge/prompt/commit/84d3012))
* **git:** add a git clone helper that automatically tracks all remote branches ([72495ae](https://github.com/pulsebridge/prompt/commit/72495ae))
* **git:** add git-extras including line counts from repos ([7db9321](https://github.com/pulsebridge/prompt/commit/7db9321))
* **git:** add shortcut for initializing git repos the right way ([7ae4f5c](https://github.com/pulsebridge/prompt/commit/7ae4f5c))
* **git:** add support for bash-completion of git flow ([f95f834](https://github.com/pulsebridge/prompt/commit/f95f834))
* **prompt:** add counts to the colorized git prompt ([d238f66](https://github.com/pulsebridge/prompt/commit/d238f66))
* **prompt:** indicate (ssh) on prompt when connected to a remote ([ff4a33c](https://github.com/pulsebridge/prompt/commit/ff4a33c))
* **prompt:** updated the git prompt to be colorized based on the current state ([71e66cc](https://github.com/pulsebridge/prompt/commit/71e66cc))
* **theme:** updated the theme, prompt, and bashrc for improved colors ([b875434](https://github.com/pulsebridge/prompt/commit/b875434))
* **utility:** add a do-repeat command which can be used to exec a cmd a set number of times ([736035d](https://github.com/pulsebridge/prompt/commit/736035d))
* **xplat:** add checks for darwin for unique features ([deadbe9](https://github.com/pulsebridge/prompt/commit/deadbe9))
* **xplat:** improve cross-platform capabilities ([acab311](https://github.com/pulsebridge/prompt/commit/acab311))
