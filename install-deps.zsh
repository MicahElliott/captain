#! /bin/zsh

# Install a bunch of clojure and other fast tooling for linting etc

# TODO Convert this to pacrat nest.ini

mkdir -p ~/src # for clones

# rep, for running unit tests from running repl
# https://github.com/eraserhd/rep
if ! type rep >/dev/null
then print 'Installing rep to ~/bin/rep for running fast clojure unit tests'
     pushd ~/src
     git clone https://github.com/eraserhd/rep
     cd rep
     cc -g -O2 -e rep rep.c
     cp rep ~/bin
     popd
     print
fi

# gnu utils for mac
if [[ $OSTYPE =~ 'darwin.*' ]] && ! type ggrep >/dev/null
then print 'Installing gnu utils for mac'
     brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep gdate
     print
fi

# sqllint
if ! type ecpg >/dev/null
then print 'Installing postgres FE for ecpg sql linting'
     if [[ $OSTYPE =~ 'darwin.*' ]]
     then brew install libpq
     else sudo dnf install ecpg-devel
     fi
     print
fi

# Kondo
if ! type clj-kondo >/dev/null
then print 'Installing clj-kondo for linting'
     if [[ $OSTYPE =~ 'darwin.*' ]]
     wget https://github.com/clj-kondo/clj-kondo/releases/download/v2024.11.14/clj-kondo-2024.11.14-linux-aarch64.zip
fi

# Splint (and bbin)
# https://cljdoc.org/d/io.github.noahtheduke/splint/1.10.1/doc/installation
# https://github.com/babashka/bbin (for splint)
if ! type bbin >/dev/null
then print 'Installing babashka bbin (for splint)'
     if [[ $OSTYPE =~ 'darwin.*' ]]
     then brew install babashka/brew/bbin
     else curl -o- -L https://raw.githubusercontent.com/babashka/bbin/v0.2.4/bbin > ~/bin/bbin && chmod +x ~/bin/bbin
     fi
     print 'Installing splint'
     bbin install io.github.noahtheduke/splint
     print 'Do: Add to your path for splint: path+=~/.local/bin'
fi

if ! type cljfmt >/dev/null
then print 'Do: Install fast/native cljfmt from: https://github.com/bsless/cljfmt-graalvm'
     print -- '- Install GraalVM: https://github.com/graalvm/graalvm-ce-builds/releases'
     print -- '- Set GRAALVM_HOME to the unpacked archive or add $GRAALVM_HOME/bin to your path'
     print 'Cloning cljfmt'
     git clone https://github.com/bsless/cljfmt-graalvm
     print 'Do: cd cljfmt-graalvm && ./script/compile'
     print
fi

if ! type mdl >/dev/null
then print 'Installing markdownlint'
     gem install mdl
     print
fi
