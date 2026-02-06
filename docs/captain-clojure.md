# Captain Git Hook Management for Clojure

[Captain](https://github.com/MicahElliott/captain) is a simple single-file
shell script that replaces our previous `.githooks/pre-commit` script. It
provides a way to cleanly run linters, formatters, testers, etc -- via git
hooks, without having to do manual steps.

Hopefully your editor runs a couple of these tools automatically on-save
(kondo, cljfmt), but it's still helpful to run more things explicitly during
commits.

The only involved bit of setting up Captain is installing the Clojure tools it
uses, which we should be installing and using anyway. So this doc is
essentially a guide to getting a more comprehensive tools setup.

## Installing CC tooling

These tools are described in more detail in our [devsetup](docs/devsetup.md)
guide, but the following are commands you can paste and should be all you need.

### Misc setup

```shell
brew install eget  # OR: curl https://zyedidia.github.io/eget.sh | sh
mkdir ~/.local/bin
path+=~/.local/bin  # also add to .zshrc
cd .../your/cc
git config core.hooksPath .capt/hooks  # this enables capt
```

### Clojure and SQL tools

Although you may have already installed `clojure-lsp` which includes indirect
access to `clj-kondo` and `cljfmt`, the easiest way to invoke them directly is
to redundantly install them:

Lint and format Clojure files:

```shell
brew install clj-kondo cljfmt
```

PSQL front-end linter `ecpg`:

```shell
brew install libpq  # follow brew steps if you already installed brew-postgres
```

Connect to a running repl with `rep`:

```shell
git clone https://github.com/eraserhd/rep
cd rep
make  # ignore xml error
cp ./rep ~/.local/bin
```

Lint commit messages with `gommit`:

```shell
EGET_BIN=~/.local/bin eget antham/gommit
```

(Optional) Lint markdown files with `mdl`:

```shell
git clone https://github.com/markdownlint/markdownlint; cd markdownlint; rake install
```

### Captain

```shell
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep  # not needed in WSL
brew install terminal-notifier
EGET_BIN=~/.local/bin eget micahelliott/captain  # choose last option: all
```

To see Captain's built-in help:

```shell
capt help
```

To see more output from running subcommands:

```shell
export CAPT_VERBOSE=1
```

If you ever find `capt` misbehaving, disable it with:

```shell
export CAPT_DISABLE=1
```
