# Captain git-hook manager control file

# Why is there no shellcheck? Doesn't seem to work well for too many things with Zsh.
pre_commit=(
    'hithere: hello $CAPT_FILES_CHANGED'
    'doclint(md|mkd): mdl $CAPT_FILES_CHANGED' # redundant with markdownlint but good for testing
    markdownlint
    # -markdownlint
    missingnewline
    "fixmes: git-confirm.sh"
)

commit_msg=( msglint )

prepare_commit_msg=( # br2msg
    
)

post_commit=( colorquote )

post_checkout=(
    # migalert
    # bundler
)

# after a commit is modified by an amend or rebase
post_rewrite=( # migalert
)

pre_push=(
    # run-test-suite
    # nvd
)

integration=( colorquote 'hi: hello some test params' markdownlint )
