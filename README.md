# Captain

Captain is a very simple, worse-is-better approach to git-hook managmement,
with no magic, and just a tiny script to download. Suited for a team,
extensible for you.

## Why Captain instead of X?

Compared to Lefthook, Husky, and Overcommit, Captain is:

- Tiny and transparent: read and understand the whole code base (one file) in minutes
- Simple: workflow is just calling the scripts you probably already have
- No dependencies: if you have Zsh, you're already done
- Compatible: other managers don't play nice with git clients, but Captain does
- Basic: config is just a Zsh file with arrays of scripts for each hook (no yaml etc)
- Clear: your standard git-hooks become one-line calls to `capt`
- Fun: get ideas for new hooks and be entertained by the Captain!

And like those others, Captain is also:

- Shareable: your whole team has a set of common hooks
- Individual: you can maintain your own set of hooks
- Batteries: vars for which files changed, multi-OS functions
- Customizeable: run hooks in parallel, with verbosity, etc; run from personal
  dirs or team's

## Do I need a hook manager?

Probably. Without a hook manager, it's challenging to have a single set of
hooks that all developers agree on. Also, having multiple tasks in a single
hook file gets slow and ugly: managers give you organization, parallelism, and
some shortcut facilities. Over time, you come up with more ideas for things
that can run automatically as hooks, and eventually, your standard hook files
just get unmanageable.

## Insallation

Each developer on your of your code base is encouraged to install Captain.

1. Put the `capt` zsh script on your `path`
1. Copy the set of one-liner git-hooks into your repo's `.git/hooks` dir
1. Create a `.capt` file
1. Create a `.capt-local` file
1. Point Captain to your repo (team-shared) scripts

## Setup and configuration

Start by creating a simple `capt.zsh` control file:

``` zsh
# Captain git-hook manager control file

pre_commit=(
    "linter:        clj-kondo $CAPT_CHANGES &" # linting of files being committed
    'formatter:     cljfmt &'                  # reformat or check for poor formatting
    'fixmes:        git-confirm.sh'            # look for/prompt on FIXMEs
    'test-suite.py: run-minimal-test-suite $CAPT_CHANGES'
)
commit_msg=(
    'commit-legalizer: commitlint $(cat "$1")' # ensure log message meets standards
)
post_commit=(
    "stimulator: play-post-commit-sound.sh"           # happy music on successful commit
    "colorizer:  commit-colors $(git rev-parse HEAD)" # more confirmation rewards
)
post_checkout=(
    "mig-alerter: alert-migrations-pending.zsh" # inform that action is needed
)
```

Some things to notice in that file:

- All the hooks/scripts are short and live in a single place
- Each "hook section" is just a Zsh array named for git's conventions
- Each script is a line with a `somename:` prefix, then the eval'd command
- The `linter` and `formatter` are run in parallel by being backgrounded (`&`)
- It doesn't generally matter whether you single- or double-quote commands
- The `$CAPT_CHANGES` is the convenient list of files that are part of the commit
- The `test-suite.py` is a local script not on `path`; Captain figures that out
- It gets put into git at your project-root and is used by all devs on the project

Now say you want to enable those four git-hooks (comprising 8 scripts). Here's
how you would create the corresponding hooks, which can be done by each
developer upon cloning the project repo:

```shell
for hookfile in pre-commit commit-message post-checkout post-checkout; do
    echo '#!/bin/zsh\ncapt $(basename $0) $@' >.git/hooks/$hookfile
    chmod +x .git/hooks/$hookfile
done
```

That enables git to do its default thing: next time you (or anyone) does a
`git commit`, git will fire its default `pre-commit` script (you just created
that) which just calls `capt` with git's args. Then `capt` does its job of
finding the `capt.zsh` control file that you created.

## User-local additional hooks

Suppose you have even higher personal standards than the rest of your team. I.e,
you have OCD about line length. You can ensure that all of _your_ commits
conform to your OCD by creating another local-only `captlocal.zsh` control
file.

``` zsh
pre_commit=( 'line-lengh-nazi: check-line-length' ... other-custom-checkers... )
```

## How to use Captain

## How to bring Captain to your team

Try using a new hook locally on your own for a while. Once you're confident is
does its thing well, confirm with the team that you're moving it into the
shared `.captscripts/` dir. If this is a script that will block their commit
or build, you want to make sure everyone is aware and knows how to comply with
it.

## Treasure trove of hooks

There is a wealth of git-hooks in the wild, and of course you can come up with
your own. Here is a list of themes to start with:

- linting: code, docs (safety etc violations, fixmes)
- formatting: code, commit messages (style, indentation, whitespace, line length)
- alerting: migrations to be run
- deprecations: insecure or outdated deps
- audio effects: good or bad things completed
