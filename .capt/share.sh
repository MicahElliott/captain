# Captain git-hook manager control file

pre_commit=(
    'doclint(md|mkd): mdl $CAPT_FILES_CHANGED'
    markdownlint
    "fixmes: git-confirm.sh"
    # color-commit
)

commit_msg=( msglint )
