#! /bin/bash

# Reject NSs touched that have missing docstring

echo "Checking for missing NS docstrings"

# git fetch --quiet origin master:refs/remotes/origin/master
# cljfiles=( $(git diff --name-only origin/master HEAD | grep 'src/.*\.clj$') )
cljfiles=( $@ )
# echo ${#cljfiles[@]}
if (( ${#cljfiles[@]} == 0 )); then
    # echo -e "No clj files in this PR\nOK"
    exit
fi

# Find files with occurrence of `ns` followed by immediately (next line) by `(:require`
# culprits=( $(grep -Plzo '\(ns [a-z].*\n +\(:require' $(git diff --name-only "$branch" master | grep '\.clj$')) )
culprits=( $(grep -Plzo '\(ns [a-z].*\n +\(:require' $cljfiles) )
# echo ${#culprits[@]}

if (( ${#culprits[@]} > 0 )) ; then
    echo "WARNING!"
    echo "WARNING! You touched file(s) that are missing a namespace-level docstring."
    echo "WARNING!"
    echo -e "\nCULPRITS:\n$culprits"
    echo -e "\nYou presumably know enough about this NS to change it, so please add a docstring while you're at it."
    echo "If you are not confident in writing a paragraph about its purpose, please consult someone from its git-history and ask them to send you a blurb."
    echo "Or, at least try for a single-sentence summary; everyone thanks you."
    echo "Or, mark the NS as ^:deprecated. Or just delete it."
    echo "You could even mark the local-only functions as private (defn-) to help our onion grow!"
    echo "More details: https://github.com/dividendsolar/crawlingchaos/pull/8334"
    echo -e "\nWARNING!"
    echo "WARNING! This violation will result in your build being blocked on July 1"
    echo "WARNING!"

    exit # 1 # block the build if this happens, starting July 1
else
    echo "OK"
fi
