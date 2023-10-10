# Captain git-hook manager control file

pre_commit=(
    'doclint(md|mkd): mdl $CAPT_FILES_CHANGED'
    markdownlint
    "fixmes: git-confirm.sh"
)

commit_msg=( msglint )

post_commit=( colorquote )
