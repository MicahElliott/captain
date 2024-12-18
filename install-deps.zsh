#! /bin/zsh

# rep, for running unit tests: https://github.com/eraserhd/rep
print 'Installing rep for running fast clojure unit tests'
cd src
git clone https://github.com/eraserhd/rep
cd rep
cc -g -O2 -e rep rep.c
cp rep ~/bin

# gnu utils mac
print 'Installing gnu utils for mac'
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

# sqllint
print 'Installing postgres libpq for ecpg sql linting'
brew install libpq

# https://github.com/babashka/bbin (for splint)
print 'Installing babashka bbin (for splint)'
brew install babashka/brew/bbin

# https://cljdoc.org/d/io.github.noahtheduke/splint/1.10.1/doc/installation
print 'Installing splint'
bbin install io.github.noahtheduke/splint

print 'Add to your path for splint: path+=~/.local/bin'
