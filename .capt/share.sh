# Captain git-hook manager control file

# Why is there no shellcheck? Doesn't seem to work well for too many things with Zsh.
pre_commit=(
    'hithere: hello $CAPT_FILES_CHANGED'
    # redundant with markdownlint but for testing filters etc
    'doclint(md|mkd): mdl $CAPT_FILES_CHANGED ## check markdown for violations'
    markdownlint
    # -markdownlint
    missingnewline
    "fixmes: git-confirm.sh ## check for FIXMEs etc"
)

commit_msg=( msglint )

prepare_commit_msg=( br2msg )

post_commit=( colorquote )

post_checkout=(
    'fake-migalert: print "faking a checkout trigger" ## fake a migalert'
    'fake-bundler:  print "pretending to run bundler" ## bundle resources'
)

# after a commit is modified by an amend or rebase
post_rewrite=( # migalert
)

pre_push=(
    # run-test-suite
    # nvd
)

integration=( colorquote 'hi: hello some test params' markdownlint )
