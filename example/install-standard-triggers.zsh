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
fi

### Generic (any OS)

# Captain of course!
cd ~/src
git clone https://github.com/MicahElliott/captain  # to get all tooling
path+=~/src/captain/bin

# commitlint
npm install -g @commitlint/{config-conventional,cli}

# bbin: https://github.com/babashka/bbin/blob/main/docs/installation.md#manual-linux-and-macos
mkdir -p ~/.local/bin && curl -o- -L https://raw.githubusercontent.com/babashka/bbin/v0.2.1/bbin > ~/.local/bin/bbin && chmod +x ~/.local/bin/bbin

# splint: https://cljdoc.org/d/io.github.noahtheduke/splint/1.10.1/doc/installation
bbin install io.github.noahtheduke/splint
