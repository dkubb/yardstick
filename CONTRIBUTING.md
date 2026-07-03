# Contributing to yardstick

Thanks for your interest in improving yardstick! This guide explains how to set
up your environment, the standards your changes need to meet, and how to submit
your work.

If you are planning a large or potentially controversial change, please
[open an issue](https://github.com/dkubb/yardstick/issues) to discuss it before
doing the work, so we can agree on the direction.

- [Prerequisites](#prerequisites)
- [Getting started](#getting-started)
- [Making changes](#making-changes)
- [Running the checks](#running-the-checks)
- [Commit messages](#commit-messages)
- [Versioning and releases](#versioning-and-releases)
- [Submitting your change](#submitting-your-change)

## Prerequisites

* Ruby >= 3.3 (see `required_ruby_version` in `yardstick.gemspec`)
* Optional: Node.js / npm — used to install the local Conventional Commit
  hook (Husky + commitlint). If npm is not available the hook is skipped and
  commit messages are validated only in CI.

## Getting started

Fork and clone the repository, then run the setup script from the project root:

```sh
bin/setup
```

This installs the Ruby gem dependencies with Bundler and, when npm is present,
installs the `commit-msg` hook that validates your commit messages locally.

You can open an interactive console with the gem loaded via:

```sh
bin/console
```

## Making changes

* Add or update specs for every change. The suite must stay green and coverage
  must remain at 100% (both line coverage via SimpleCov and documentation
  coverage measured by yardstick itself).
* Document public and semipublic methods with YARD. Documentation coverage is
  enforced at 100%.
* Code style is enforced by RuboCop using `config/rubocop.yml`. Additional
  static analysis is provided by reek, flay, and flog.

## Running the checks

Run the full continuous-integration suite before submitting:

```sh
bundle exec rake ci
```

This runs RuboCop, reek, flay, flog, the yardstick documentation-coverage
check, and the full spec suite with 100% line-coverage enforcement — the same
checks that run in CI. Everything must pass with no regressions.

Individual tasks are also available, for example:

```sh
bundle exec rake spec              # run the full spec suite
bundle exec rake spec:unit         # run only unit specs
bundle exec rake spec:integration  # run only integration specs
bundle exec rake metrics:rubocop   # run RuboCop
bundle exec rake yard              # generate documentation
```

Mutation testing is available but excluded from `rake ci` because it is slow:

```sh
bundle exec rake metrics:mutant
```

## Commit messages

This project uses [Conventional Commits](https://www.conventionalcommits.org).
Commit messages are validated locally by the Husky `commit-msg` hook (when npm
is installed) and by CI on every pull request.

Each commit message must start with one of these types:

`build`, `ci`, `chore`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`,
`style`, `test`

For example:

```
fix: correct the coverage percentage rounding
```

The commit history drives releases, so write clear, accurately-typed messages.

> **Note:** Due to a limitation in commitlint, commit messages must not contain
> the `#` character anywhere — including the subject and body. A `#` causes
> commitlint to treat the rest of the line as a comment and strip it, which
> leads to confusing validation failures. Refer to issues or numbers without
> the `#` (for example, "issue 42" or "GH-42" instead of "#42").

## Versioning and releases

Do not bump the version or edit `CHANGELOG.md` by hand. Releases are automated
with [release-please](https://github.com/googleapis/release-please): it derives
the next version and changelog from the Conventional Commit history and opens a
release pull request. Merging that pull request publishes the gem.

## Submitting your change

* Work on a topic branch.
* Keep your commits focused, and make sure `rake ci` runs without error at
  each commit.
* Open a pull request against `master`.
