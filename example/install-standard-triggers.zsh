#! /bin/zsh

### Install a bunch of widely used ckeckers suitable for most projects
#
#   Just an example for a typical clojure project; adjust to your needs/stack
#   Noteworthy here are the multi-OS approach, and guiding your team to all
#   get the necessary tools installed to be successful with clean coding

### OS-specific
if [[ $OSTYPE == darwin* ]] ; then
    brew install borkdude/brew/clj-kondo
else # check here for linux distro, etc
    curl -sLO https://raw.githubusercontent.com/clj-kondo/clj-kondo/master/script/install-clj-kondo
    chmod +x install-clj-kondo
    ./install-clj-kondo

    
    # tidy html: https://github.com/htacg/tidy-html5
    dnf install tidy

fi

### Generic (any OS)

# Captain of course!
cd ~/src
git clone https://github.com/MicahElliott/captain  # to get all tooling
path+=~/src/captain/bin

# commitlint
npm install -g '@commitlint/{config-conventional,cli}'

# bbin: https://github.com/babashka/bbin/blob/main/docs/installation.md#manual-linux-and-macos
mkdir -p ~/.local/bin && curl -o- -L https://raw.githubusercontent.com/babashka/bbin/v0.2.1/bbin > ~/.local/bin/bbin && chmod +x ~/.local/bin/bbin

# splint: https://cljdoc.org/d/io.github.noahtheduke/splint/1.10.1/doc/installation
bbin install io.github.noahtheduke/splint

# Antq: https://github.com/liquidz/antq (2+m to run, so CI only?)
clojure -Tantq outdated

# Set up NPM: https://github.com/sindresorhus/guides/blob/main/npm-global-without-sudo.md

# cspell: http://cspell.org/
npm install -g git+https://github.com/streetsidesoftware/cspell-cli

# License Finder: https://github.com/pivotal/LicenseFinder (also brew etc)
gem install license_finder

# sqlint: https://github.com/purcell/sqlint
gem install sqlint

# yamllint: https://github.com/adrienverge/yamllint
pip install --user yamllint

# commitplease: https://github.com/jzaefferer/commitplease/
npm install -g commitplease

# git-guilt: https://github.com/tj/git-extras/blob/main/man/git-guilt.md
# git-extras: https://github.com/tj/git-extras/blob/main/Installation.md
