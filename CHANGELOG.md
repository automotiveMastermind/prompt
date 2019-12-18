# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [7.0.1](https://github.com/automotivemastermind/prompt/compare/v7.0.0...v7.0.1) (2019-12-18)


### Bug Fixes

* use current shell if bash/zsh ([#39](https://github.com/automotivemastermind/prompt/issues/39)) ([f3834ee](https://github.com/automotivemastermind/prompt/commit/f3834ee))



## [7.0.0](https://github.com/automotivemastermind/prompt/compare/v6.3.1...v7.0.0) (2019-12-18)


### Bug Fixes

* theme launcher ([#37](https://github.com/automotivemastermind/prompt/issues/37)) ([e124ce4](https://github.com/automotivemastermind/prompt/commit/e124ce4))


### Build System

* fix git user/email in publish ([#40](https://github.com/automotivemastermind/prompt/issues/40)) ([1ce6870](https://github.com/automotivemastermind/prompt/commit/1ce6870))
* fix publish for prompt ([#38](https://github.com/automotivemastermind/prompt/issues/38)) ([b7a33b0](https://github.com/automotivemastermind/prompt/commit/b7a33b0))


### Features

* add zsh and dash support to prompt ([#32](https://github.com/automotivemastermind/prompt/issues/32)) ([275f62c](https://github.com/automotivemastermind/prompt/commit/275f62c))


### BREAKING CHANGES

* While this is not an actual breaking change, quite a bit has changed with
regard to how prompt actually works. We want to notify users that this may
result is some level of bugs as test coverage of scripts like this one is
incredibly difficult.



### [6.3.1](https://github.com/automotivemastermind/prompt/compare/v6.3.0...v6.3.1) (2019-11-05)



## [6.3.0](https://github.com/automotivemastermind/prompt/compare/v6.2.2...v6.3.0) (2019-10-22)


### Features

* add minikube install for macos ([#30](https://github.com/automotivemastermind/prompt/issues/30)) ([ff39175](https://github.com/automotivemastermind/prompt/commit/ff39175))



### [6.2.2](https://github.com/automotivemastermind/prompt/compare/v6.2.0...v6.2.2) (2019-07-26)


### Build System

* force update of lodash.template ([#27](https://github.com/automotivemastermind/prompt/issues/27)) ([2fe19e5](https://github.com/automotivemastermind/prompt/commit/2fe19e5))
* resolve security issues in dependencies ([#26](https://github.com/automotivemastermind/prompt/issues/26)) ([74784cb](https://github.com/automotivemastermind/prompt/commit/74784cb))



## [6.2.0](https://github.com/automotivemastermind/prompt/compare/v6.0.2...v6.2.0) (2019-06-26)


### Bug Fixes

* remove invalid scripts ([#21](https://github.com/automotivemastermind/prompt/issues/21)) ([d3a9c60](https://github.com/automotivemastermind/prompt/commit/d3a9c60))


### Build System

* fix deploy docker image ([0d6b18e](https://github.com/automotivemastermind/prompt/commit/0d6b18e))
* move to circle ci ([#24](https://github.com/automotivemastermind/prompt/issues/24)) ([0b09959](https://github.com/automotivemastermind/prompt/commit/0b09959)), closes [#23](https://github.com/automotivemastermind/prompt/issues/23)
* run deploy stage without rebuilding on master ([#25](https://github.com/automotivemastermind/prompt/issues/25)) ([c402a9f](https://github.com/automotivemastermind/prompt/commit/c402a9f))
* set git email/name on deploy task ([95d2825](https://github.com/automotivemastermind/prompt/commit/95d2825))


### Features

* **aws-install:** add install for aws toolchain ([4989391](https://github.com/automotivemastermind/prompt/commit/4989391))



## [6.1.0](https://github.com/automotivemastermind/prompt/compare/v6.0.2...v6.1.0) (2019-06-26)


### Bug Fixes

* remove invalid scripts ([#21](https://github.com/automotivemastermind/prompt/issues/21)) ([d3a9c60](https://github.com/automotivemastermind/prompt/commit/d3a9c60))


### Features

* **aws-install:** add install for aws toolchain ([4989391](https://github.com/automotivemastermind/prompt/commit/4989391))



### [6.0.2](https://github.com/automotivemastermind/prompt/compare/v6.0.1...v6.0.2) (2019-06-26)


### Bug Fixes

* **dotnet:** set paths for global tools ([#19](https://github.com/automotivemastermind/prompt/issues/19)) ([d16a5f2](https://github.com/automotivemastermind/prompt/commit/d16a5f2))



### [6.0.1](https://github.com/automotivemastermind/prompt/compare/v6.0.0...v6.0.1) (2019-06-18)


### Bug Fixes

* **user:** source user bashrc after platform ([#18](https://github.com/automotivemastermind/prompt/issues/18)) ([aa8ac25](https://github.com/automotivemastermind/prompt/commit/aa8ac25))



## [6.0.0](https://github.com/automotivemastermind/prompt/compare/v5.2.0...v6.0.0) (2019-06-12)


### Features

* add golang to darwin and set go paths ([6128192](https://github.com/automotivemastermind/prompt/commit/6128192))


### BREAKING CHANGES

* The `git-flow-avh`, `git-extras`, and `git-flow-completion` tools are no
installed by default. While git-flow is still a fairly popular workflow
for private repositories, this prompt is designed to favor OSS
development where forks are the norm.

You can review the diff of this commit to see how they were installed on
each platform if you would like to continue using these tools.



## [5.2.0](https://github.com/automotivemastermind/prompt/compare/v5.1.0...v5.2.0) (2019-05-09)


### Features

* **update-sln:** add support for glob patterns ([#16](https://github.com/automotivemastermind/prompt/issues/16)) ([b4c4b7e](https://github.com/automotivemastermind/prompt/commit/b4c4b7e))



## [5.1.0](https://github.com/automotivemastermind/prompt/compare/v5.0.0...v5.1.0) (2019-05-07)


### Build System

* update standard-version package ([2d255cd](https://github.com/automotivemastermind/prompt/commit/2d255cd))


### Features

* make update-sln diff aware ([#15](https://github.com/automotivemastermind/prompt/issues/15)) ([4baa9f7](https://github.com/automotivemastermind/prompt/commit/4baa9f7))



<a name="5.0.0"></a>
# [5.0.0](https://github.com/automotivemastermind/prompt/compare/v4.0.6...v5.0.0) (2018-09-05)


### Features

* use scripts instead of sourced functions ([7cdde0a](https://github.com/automotivemastermind/prompt/commit/7cdde0a))


### BREAKING CHANGES

* `minikube-install` is no longer available as minikube is now included in
Docker Desktop for both Mac and Windows.

Git extensions based on git-flow have been removed. These were rarely
utilized.



<a name="4.0.6"></a>
## [4.0.6](https://github.com/automotivemastermind/prompt/compare/v4.0.5...v4.0.6) (2018-04-22)


### Bug Fixes

* **list-directory:** fix aliases for la, ll, lla, and lsp ([#14](https://github.com/automotivemastermind/prompt/issues/14)) ([8b8a173](https://github.com/automotivemastermind/prompt/commit/8b8a173))



<a name="4.0.5"></a>
## [4.0.5](https://github.com/automotivemastermind/prompt/compare/v4.0.4...v4.0.5) (2018-03-06)


### Bug Fixes

* prompt updates on sierra ([#12](https://github.com/automotivemastermind/prompt/issues/12)) ([6147b37](https://github.com/automotivemastermind/prompt/commit/6147b37))



<a name="4.0.4"></a>
## [4.0.4](https://github.com/automotivemastermind/prompt/compare/v4.0.3...v4.0.4) (2017-10-31)


### Bug Fixes

* **add-var:** fix issue with newline ([a47ee5f](https://github.com/automotivemastermind/prompt/commit/a47ee5f))



<a name="4.0.3"></a>
## [4.0.3](https://github.com/automotivemastermind/prompt/compare/v4.0.2...v4.0.3) (2017-10-31)


### Bug Fixes

* **update:** fix issue when SHA cannot be found ([1e014a8](https://github.com/automotivemastermind/prompt/commit/1e014a8))



<a name="4.0.2"></a>
## [4.0.2](https://github.com/automotivemastermind/prompt/compare/v4.0.1...v4.0.2) (2017-10-13)


### Bug Fixes

* **dotnet-install:** do not use servicing builds ([c878b77](https://github.com/automotivemastermind/prompt/commit/c878b77))



<a name="4.0.1"></a>
## [4.0.1](https://github.com/automotivemastermind/prompt/compare/v4.0.0...v4.0.1) (2017-10-11)


### Bug Fixes

* **npm:** fix npm completion order issue ([d928464](https://github.com/automotivemastermind/prompt/commit/d928464))



<a name="4.0.0"></a>
# [4.0.0](https://github.com/automotivemastermind/prompt/compare/v3.19.0...v4.0.0) (2017-09-20)


### Features

* **bash:** install latest bash on Darwin ([e16e99b](https://github.com/automotivemastermind/prompt/commit/e16e99b))


### BREAKING CHANGES

* **bash:** This version of prompt will install and configure a new version of bash as the default shell for the user. It does NOT
symlink over /bin/bash. Scripts that do not use /usr/bin/env in the shebang will continue to use the old version of
bash to execute the script, which should maintain backward compatibility on the platform. Please let us know if you have
any issues by creating an aptly named issue on github!



<a name="3.19.0"></a>
# [3.19.0](https://github.com/automotivemastermind/prompt/compare/v3.18.0...v3.19.0) (2017-08-31)


### Features

* **docker:** add update for all images ([5167da4](https://github.com/automotivemastermind/prompt/commit/5167da4))



<a name="3.18.0"></a>
# [3.18.0](https://github.com/automotivemastermind/prompt/compare/v3.17.0...v3.18.0) (2017-08-31)


### Features

* **gcloud:** add gcloud completion ([f553e16](https://github.com/automotivemastermind/prompt/commit/f553e16))



<a name="3.17.0"></a>
# [3.17.0](https://github.com/automotivemastermind/prompt/compare/v3.16.0...v3.17.0) (2017-08-31)


### Features

* **gcloud:** add gcloud-install script ([c9631bd](https://github.com/automotivemastermind/prompt/commit/c9631bd))



<a name="3.16.0"></a>
# [3.16.0](https://github.com/automotivemastermind/prompt/compare/v3.15.2...v3.16.0) (2017-08-14)


### Features

* **helm:** add helm install and completion ([bbf2462](https://github.com/automotivemastermind/prompt/commit/bbf2462))



<a name="3.15.2"></a>
## [3.15.2](https://github.com/automotivemastermind/prompt/compare/v3.15.1...v3.15.2) (2017-07-12)



<a name="3.15.1"></a>
## [3.15.1](https://github.com/automotivemastermind/prompt/compare/v3.15.0...v3.15.1) (2017-07-12)



<a name="3.15.0"></a>
# [3.15.0](https://github.com/automotivemastermind/prompt/compare/v3.14.0...v3.15.0) (2017-07-02)


### Features

* **bash:** enable exglob for bash ([b778112](https://github.com/automotivemastermind/prompt/commit/b778112))



<a name="3.14.0"></a>
# [3.14.0](https://github.com/automotivemastermind/prompt/compare/v3.13.0...v3.14.0) (2017-05-15)


### Features

* **dotnet-install:** add dotnet core 2.0 support ([cb21e1b](https://github.com/automotivemastermind/prompt/commit/cb21e1b))



<a name="3.13.0"></a>
# [3.13.0](https://github.com/automotivemastermind/prompt/compare/v3.12.0...v3.13.0) (2017-05-08)


### Features

* **kube:** add docker registry to minikube ([d64da08](https://github.com/automotivemastermind/prompt/commit/d64da08))



<a name="3.12.0"></a>
# [3.12.0](https://github.com/automotivemastermind/prompt/compare/v3.11.0...v3.12.0) (2017-04-11)


### Bug Fixes

* **k8s:** fix install of kubernetes ([a3c0e21](https://github.com/automotivemastermind/prompt/commit/a3c0e21))


### Features

* **prompt:** enable user-defined marker ([2c63a54](https://github.com/automotivemastermind/prompt/commit/2c63a54))



<a name="3.11.0"></a>
# [3.11.0](https://github.com/automotivemastermind/prompt/compare/v3.10.1...v3.11.0) (2017-04-09)


### Features

* **macos:** add kubernetes install support ([5892645](https://github.com/automotivemastermind/prompt/commit/5892645))



<a name="3.10.1"></a>
## [3.10.1](https://github.com/automotivemastermind/prompt/compare/v3.10.0...v3.10.1) (2017-04-09)



<a name="3.10.0"></a>
# [3.10.0](https://github.com/automotivemastermind/prompt/compare/v3.9.1...v3.10.0) (2017-04-07)


### Features

* **dotnet:** update sln with new projs ([64b2260](https://github.com/automotivemastermind/prompt/commit/64b2260))



<a name="3.9.1"></a>
## [3.9.1](https://github.com/automotivemastermind/prompt/compare/v3.9.0...v3.9.1) (2017-03-10)


### Bug Fixes

* **backup:** fix remove-backup script ([9d8b964](https://github.com/automotivemastermind/prompt/commit/9d8b964))



<a name="3.9.0"></a>
# [3.9.0](https://github.com/automotivemastermind/prompt/compare/v3.8.2...v3.9.0) (2017-03-08)


### Features

* **dotnet:** install final dotnet sdk ([2102554](https://github.com/automotivemastermind/prompt/commit/2102554))



<a name="3.8.2"></a>
## [3.8.2](https://github.com/automotivemastermind/prompt/compare/v3.8.1...v3.8.2) (2017-02-13)



<a name="3.8.1"></a>
## [3.8.1](https://github.com/automotivemastermind/prompt/compare/v3.8.0...v3.8.1) (2017-02-13)


### Bug Fixes

* **install:** remove old pulsebridge path on install ([4f5525c](https://github.com/automotivemastermind/prompt/commit/4f5525c))



<a name="3.8.0"></a>
# [3.8.0](https://github.com/automotivemastermind/prompt/compare/v3.7.0...v3.8.0) (2017-02-13)


### Features

* **am:** migrate branding to aM ([8389ee7](https://github.com/automotivemastermind/prompt/commit/8389ee7))



<a name="3.7.0"></a>
# [3.7.0](https://github.com/automotivemastermind/prompt/compare/v3.6.2...v3.7.0) (2017-01-27)


### Features

* **dotnet-install:** install all current channels ([8d7cfde](https://github.com/automotivemastermind/prompt/commit/8d7cfde))



<a name="3.6.2"></a>
## [3.6.2](https://github.com/automotivemastermind/prompt/compare/v3.6.1...v3.6.2) (2016-12-28)



<a name="3.6.1"></a>
## [3.6.1](https://github.com/automotivemastermind/prompt/compare/v3.6.0...v3.6.1) (2016-12-28)



<a name="3.6.0"></a>
# [3.6.0](https://github.com/automotivemastermind/prompt/compare/v3.5.7...v3.6.0) (2016-12-28)


### Features

* **open-url:** add support for opening a url across platforms ([8509caa](https://github.com/automotivemastermind/prompt/commit/8509caa))



<a name="3.5.7"></a>
## [3.5.7](https://github.com/automotivemastermind/prompt/compare/v3.5.6...v3.5.7) (2016-12-28)



<a name="3.5.6"></a>
## [3.5.6](https://github.com/automotivemastermind/prompt/compare/v3.5.5...v3.5.6) (2016-12-20)


### Bug Fixes

* **install:** fix git flow completion curl could fail ([718b975](https://github.com/automotivemastermind/prompt/commit/718b975))



<a name="3.5.5"></a>
## [3.5.5](https://github.com/automotivemastermind/prompt/compare/v3.5.4...v3.5.5) (2016-12-18)



<a name="3.5.4"></a>
## [3.5.4](https://github.com/automotivemastermind/prompt/compare/v3.5.3...v3.5.4) (2016-12-18)


### Bug Fixes

* **install:** source bash profile upon completion of the install ([f70e5bd](https://github.com/automotivemastermind/prompt/commit/f70e5bd))



<a name="3.5.3"></a>
## [3.5.3](https://github.com/automotivemastermind/prompt/compare/v3.5.2...v3.5.3) (2016-12-18)


### Bug Fixes

* **bashrc:** resolve an issue where directories were resolved for scripts ([fa1cd7d](https://github.com/automotivemastermind/prompt/commit/fa1cd7d))



<a name="3.5.2"></a>
## [3.5.2](https://github.com/automotivemastermind/prompt/compare/v3.5.1...v3.5.2) (2016-12-18)


### Bug Fixes

* **bashrc:** fix an issue with the scripts path in bashrc ([de37ef1](https://github.com/automotivemastermind/prompt/commit/de37ef1))



<a name="3.5.1"></a>
## [3.5.1](https://github.com/automotivemastermind/prompt/compare/v3.5.0...v3.5.1) (2016-12-18)



<a name="3.5.0"></a>
# [3.5.0](https://github.com/automotivemastermind/prompt/compare/v3.4.4...v3.5.0) (2016-12-18)


### Features

* **install:** open a new bash process automatically ([3566c85](https://github.com/automotivemastermind/prompt/commit/3566c85))



<a name="3.4.4"></a>
## [3.4.4](https://github.com/automotivemastermind/prompt/compare/v3.4.3...v3.4.4) (2016-12-14)



<a name="3.4.3"></a>
## [3.4.3](https://github.com/automotivemastermind/prompt/compare/v3.4.2...v3.4.3) (2016-12-14)


### Bug Fixes

* **update:** fix issue where prompt was left in temp path during update ([9d1a62b](https://github.com/automotivemastermind/prompt/commit/9d1a62b))



<a name="3.4.2"></a>
## [3.4.2](https://github.com/automotivemastermind/prompt/compare/v3.4.1...v3.4.2) (2016-12-14)


### Bug Fixes

* **install:** use remote sha for version check ([b05f6e4](https://github.com/automotivemastermind/prompt/commit/b05f6e4))



<a name="3.4.1"></a>
## [3.4.1](https://github.com/automotivemastermind/prompt/compare/v3.4.0...v3.4.1) (2016-12-14)



<a name="3.4.0"></a>
# [3.4.0](https://github.com/automotivemastermind/prompt/compare/v3.3.1...v3.4.0) (2016-12-14)


### Features

* **update:** add support for self-update ([ff98806](https://github.com/automotivemastermind/prompt/commit/ff98806))



<a name="3.3.1"></a>
## [3.3.1](https://github.com/automotivemastermind/prompt/compare/v3.3.0...v3.3.1) (2016-12-14)


### Bug Fixes

* **dotnet-install:** remove reset in dotnet-install ([ad1e15e](https://github.com/automotivemastermind/prompt/commit/ad1e15e))



<a name="3.3.0"></a>
# [3.3.0](https://github.com/automotivemastermind/prompt/compare/v3.2.1...v3.3.0) (2016-12-14)


### Features

* **linux:** add support for debian, ubuntu, and fedora ([72f23e7](https://github.com/automotivemastermind/prompt/commit/72f23e7))



<a name="3.2.1"></a>
## [3.2.1](https://github.com/automotivemastermind/prompt/compare/v3.2.0...v3.2.1) (2016-12-12)



<a name="3.2.0"></a>
# [3.2.0](https://github.com/automotivemastermind/prompt/compare/v3.1.0...v3.2.0) (2016-12-12)


### Features

* **bootstrap:** add support for one-line bootstrap ([34e1404](https://github.com/automotivemastermind/prompt/commit/34e1404))



<a name="3.1.0"></a>
# [3.1.0](https://github.com/automotivemastermind/prompt/compare/v3.0.1...v3.1.0) (2016-12-01)


### Features

* **editor:** use vscode as the default system-wide editor ([b2fe9d8](https://github.com/automotivemastermind/prompt/commit/b2fe9d8))



<a name="3.0.1"></a>
## [3.0.1](https://github.com/automotivemastermind/prompt/compare/v3.0.0...v3.0.1) (2016-12-01)



<a name="3.0.0"></a>
# [3.0.0](https://github.com/automotivemastermind/prompt/compare/v2.0.0...v3.0.0) (2016-11-29)


### Code Refactoring

* **docker-gc:** replace docker-gc with bash functions ([a71c209](https://github.com/automotivemastermind/prompt/commit/a71c209))


### BREAKING CHANGES

* docker-gc: dotnet-install has been removed and is no longer available



<a name="2.0.0"></a>
# [2.0.0](https://github.com/automotivemastermind/prompt/compare/v1.1.0...v2.0.0) (2016-11-29)


### Features

* **docker-gc:** add support for docker-gc as a container ([a73def0](https://github.com/automotivemastermind/prompt/commit/a73def0))


### BREAKING CHANGES

* docker-gc: The project has been renamed to promptMastermind and the path in which it is saved
now exists at ~/.am/prompt. Backward compatibility for restoring bookmarks
is not available. Please restore the bookmarks yourself by copying the bookmarks.sh
file from the ./backup/<DATE>/scripts/bookmarks.sh path to the
$AM_PROMPT/scripts/bookmarks.sh path.



<a name="1.1.0"></a>
# [1.1.0](https://github.com/automotivemastermind/prompt/compare/v1.0.2...v1.1.0) (2016-11-14)


### Bug Fixes

* **brew:** correct brew link ([34528d7](https://github.com/automotivemastermind/prompt/commit/34528d7))


### Features

* **nvm:** add support for nvm in place of direct node install ([5064c06](https://github.com/automotivemastermind/prompt/commit/5064c06))



<a name="1.0.3"></a>
## [1.0.3](https://github.com/automotivemastermind/prompt/compare/v1.0.2...v1.0.3) (2016-08-23)



<a name="1.0.0"></a>
# 1.0.0 (2016-08-19)


### Bug Fixes

* **dotnet:** ensure dotnet is on the path ([3dcdfef](https://github.com/automotivemastermind/prompt/commit/3dcdfef))
* **dotnet:** fix bad test for presence of dotnet ([bf2b137](https://github.com/automotivemastermind/prompt/commit/bf2b137))
* **editors:** install sublime-text3 instead of sublime-text2 ([6b560ba](https://github.com/automotivemastermind/prompt/commit/6b560ba))
* **git:** execute git flow init instead of git init in git-extensions ([f4e8db2](https://github.com/automotivemastermind/prompt/commit/f4e8db2))
* **git:** set the credential helper to osx keychain on darwin ([c454cb9](https://github.com/automotivemastermind/prompt/commit/c454cb9))
* **git:** use brew link overwrite to resolve issue where git did not link if xcode-beta was installed before prompt ([3901fd9](https://github.com/automotivemastermind/prompt/commit/3901fd9))
* **install:** fix an issue where the bash_profile could be overwritten ([54bd849](https://github.com/automotivemastermind/prompt/commit/54bd849))
* **install:** fix usage order on success function ([caef0da](https://github.com/automotivemastermind/prompt/commit/caef0da))
* **install:** remove unnecessary installs; fix git-prompt ([5290719](https://github.com/automotivemastermind/prompt/commit/5290719))
* **install:** test for .bash_profile before backing up ([68987fa](https://github.com/automotivemastermind/prompt/commit/68987fa))
* **prompt:** fix echo of tests for completion handlers ([4baf9c0](https://github.com/automotivemastermind/prompt/commit/4baf9c0))
* **prompt:** use master of posh-git-sh ([1362289](https://github.com/automotivemastermind/prompt/commit/1362289))
* **xplat:** add check for darwin for themes ([3b28084](https://github.com/automotivemastermind/prompt/commit/3b28084))
* **xplat:** do not emit error messages caused by upgrading latest brew formulae ([a742941](https://github.com/automotivemastermind/prompt/commit/a742941))


### Features

* **backup:** retain backups and avoid manipulating .ssh folder ([132af0a](https://github.com/automotivemastermind/prompt/commit/132af0a))
* **bookmark:** rename aliases for add/show bookmark ([602c12a](https://github.com/automotivemastermind/prompt/commit/602c12a))
* **completion:** add support for bash completion for gulp (if it is globally installed) ([f863b54](https://github.com/automotivemastermind/prompt/commit/f863b54))
* **dotnet:** replace dnx/dnvm with dotnet-cli ([bd6b182](https://github.com/automotivemastermind/prompt/commit/bd6b182))
* **editors:** use brew cask to install atom, visual studio code, sublime, and textmate (macOS only) ([e15dabc](https://github.com/automotivemastermind/prompt/commit/e15dabc))
* **editors:** use built-in cli for vscode, etc ([84d3012](https://github.com/automotivemastermind/prompt/commit/84d3012))
* **git:** add a git clone helper that automatically tracks all remote branches ([72495ae](https://github.com/automotivemastermind/prompt/commit/72495ae))
* **git:** add git-extras including line counts from repos ([7db9321](https://github.com/automotivemastermind/prompt/commit/7db9321))
* **git:** add shortcut for initializing git repos the right way ([7ae4f5c](https://github.com/automotivemastermind/prompt/commit/7ae4f5c))
* **git:** add support for bash-completion of git flow ([f95f834](https://github.com/automotivemastermind/prompt/commit/f95f834))
* **prompt:** add counts to the colorized git prompt ([d238f66](https://github.com/automotivemastermind/prompt/commit/d238f66))
* **prompt:** indicate (ssh) on prompt when connected to a remote ([ff4a33c](https://github.com/automotivemastermind/prompt/commit/ff4a33c))
* **prompt:** updated the git prompt to be colorized based on the current state ([71e66cc](https://github.com/automotivemastermind/prompt/commit/71e66cc))
* **theme:** updated the theme, prompt, and bashrc for improved colors ([b875434](https://github.com/automotivemastermind/prompt/commit/b875434))
* **utility:** add a do-repeat command which can be used to exec a cmd a set number of times ([736035d](https://github.com/automotivemastermind/prompt/commit/736035d))
* **xplat:** add checks for darwin for unique features ([deadbe9](https://github.com/automotivemastermind/prompt/commit/deadbe9))
* **xplat:** improve cross-platform capabilities ([acab311](https://github.com/automotivemastermind/prompt/commit/acab311))
