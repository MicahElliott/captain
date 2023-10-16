# Captain git-hook manager control file

# Why is there no shellcheck? Doesn't seem to work well for too many things with Zsh.
pre_commit=(
    'doclint(md|mkd): mdl $CAPT_FILES_CHANGED' # redundant with markdownlint but good for testing
    markdownlint
    missingnewline
    "fixmes: git-confirm.sh"
)

commit_msg=( msglint )

post_commit=( colorquote )
