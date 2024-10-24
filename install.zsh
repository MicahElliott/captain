#! /bin/zsh

# rep, for running unit tests: https://github.com/eraserhd/rep
git clone https://github.com/eraserhd/rep
cd rep
cc -g -O2 -e rep rep.c

# gnu utils mac
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

#
