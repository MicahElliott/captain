# Captain git-hook manager control file

pre_commit=(
    'doclint(md|mkd): markdownlint $CAPT_FILES_CHANGED'
    markdownlint
    "fixmes: git-confirm.sh"
    # color-commit
)

commit_msg=( msglint )
