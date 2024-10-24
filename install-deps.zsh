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

#
