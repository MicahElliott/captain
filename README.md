# Captain

Captain is a very simple, worse-is-better approach to git-hook management,
with no magic, and just a tiny script to download. Suited for a team,
extensible for you.

```text
⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⡿⢿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀
⠀⣠⣤⣶⣶⣿⣿⣿⣿⣯⠀⠀⣽⣿⣿⣿⣿⣷⣶⣤⣄⠀
⢸⣿⣿⣿⣿⣿⣿⣿⣿⡅⠉⠉⢨⣿⣿⣿⣿⣿⣿⣿⣿⡇
⠈⠻⣿⣿⣿⣿⣿⣿⣿⣥⣴⣦⣬⣿⣿⣿⣿⣿⣿⣿⠟⠁
⠀⠀⢸⣿⡿⠿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⠿⢿⣿⡇⠀⠀
⠀⣠⣾⣿⠂⠀⠀⣤⣄⠀⠀⢰⣿⣿⣿⣿⡆⠐⣿⣷⣄⠀
⠀⣿⣿⡀⠀⠀⠈⠿⠟⠀⠀⠈⠻⣿⣿⡿⠃⠀⢀⣿⣿⠀
⠀⠘⠻⢿⣷⡀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⢀⣾⡿⠟⠃⠀
⠀⠀⠀⠸⣿⣿⣷⣦⣾⣿⣿⣿⣿⣦⣴⣾⣿⣿⡇⠀⠀⠀  Aye, I'll be sinkin me hooks inta yer gits!
⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀
⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⠀
```

## Why Captain instead of another hook manager?

Compared to [Lefthook](https://github.com/evilmartians/lefthook),
[Husky](https://typicode.github.io/husky/), and
[Overcommit](https://github.com/sds/overcommit), Captain is:

- Tiny and transparent: read and understand the whole code base (one file) in minutes
- Simple: workflow is just calling the scripts you probably already have
- No dependencies: if you have Such, you're already done
- Compatible: other managers don't play nice with git clients (eg, magit), but Captain does
- Basic: config is just a Zsh file with arrays of scripts for each hook (no yaml etc)
- Clear: your standard git-hooks become one-line calls to `capt`
- Fun: get ideas for new hooks and be entertained by the Captain!
- All documentation right here: this readme is all you need
- Language and tool agnostic: you don't need to know anything about npm, ruby, etc
- Hands-off: Captain doesn't try to install things for you
- Extensible, custom for each dev: run your own hooks in addition to standards

And like those others, Captain is also:

- Shareable: your whole team has a set of common hooks
- Batteries: vars for which files changed, multi-OS functions
- Customizeable: run hooks in parallel, with verbosity, etc; run from personal
  dirs or team's

## Do I need a hook manager?

Probably. Without a hook manager, it's challenging to have a single set of
hooks that all developers agree on. Also, having multiple tasks in a single
hook file gets slow and ugly: managers give you organization, parallelism,
shortcut facilities, and more. Over time, you come up with more ideas for
things that can run automatically as hooks, and eventually, your standard hook
files can get unmanageable and messy.

Specifically, here are some of Captain's features you don't want to have to
invent, write, and/or wrap around every tool you run:

- checking for existence/installation of tool being run
- timing info of each run
- consistent and clear output of each tool
- detection and precise control of files changed from master/main
- file filtering by extension
- a single file organization of all scripts specs for whole team to control/use
- user-local scripts support for individual developer use
- one-word built-in configs (linters, etc) with pre-defined filters
- a few add-on provided linters for optional use
- OS-agnostic commands
- controllable parallel execution of each tool
- debugging aids for writing your own new scripts
- a place to collect custom scripts in your repo

## Installation

Each developer of your code base is encouraged to install Captain.

1. Put the `capt` zsh script on your `path`
1. Run the for-loop below to create any git-hooks you want
1. Create a `capt.zsh` file (or copy the one below)
1. Create a `captlocal.zsh` file for your personal additional hooks (optional)

The `capt` CLI is invoked with a single argument: the git-hook to run; e.g.,
as `capt pre-commit`; that will run all the pre-commit hooks. You can run it
`capt` directly to see/debug output, and then have all of git-hooks call it.

## Setup and configuration

Say you want to enable some git-hooks. Here's how you would create the them,
just like you may have done in the past with git. This step can be done by
each developer upon cloning the project repo:

```shell
## git's default location, not in repo; everyone has to do the hook creation
hookdir=.git/hooks
## Or like this, if you want to commit the hooks to repo, and everyone sets hooksPath
# hookdir=.capthooks
# git config core.hooksPath $hookdir
mkdir $hookdir
for hookfile in pre-commit commit-message post-checkout post-commit; do
    echo 'capt $(basename $0) $@' > $hookdir/$hookfile
    chmod +x $hookdir/$hookfile
done
```

Now your `$hookdir` looks like:

```text
.capthooks
├── commit-message
├── post-checkout
├── post-commit
└── pre-commit
```

And each of those is just a one-line invocation of `capt`. That enables git to
do its default thing: next time you (or anyone) does a `git commit`, git will
fire its default `pre-commit` script (you just created that) which just calls
`capt` with git's args. Then `capt` does its job of finding the `capt.zsh`
control file (and optionally `captlocal.zsh`) that you created.

OR, you could put all those trivial one-liner git-hooks into your project's
repo and point git to them:

```shell
git add $hookdir
git commit -m 'Add capt-driven git hooks (PSA: install capt and set hooksPath)'
```

That saves all your fellow developers from having to do anything but set:
`git config core.hooksPath $hookdir`

Now onto the simple `capt.zsh` control file at the root of your repo:

``` zsh
# Captain git-hook manager control file

pre_commit=(
    "linter:        clj-kondo $CAPT_CHANGES &" # linting of files being committed
    'formatter:     cljfmt &'                  # reformat or check for poor formatting
    'fixmes:        git-confirm.sh'            # look for/prompt on FIXMEs
    'mdlint:*.md:   mdlint $CAPT_CHANGES'
    'test-suite.rb: run-minimal-test-suite $CAPT_CHANGES'
)
commit_msg=(
    'commit-legalizer: commitlint $(cat "$1")' # ensure log message meets standards
)
post_commit=(
    "stimulator: play-post-commit-sound.sh"           # happy music on successful commit
    "colorizer:  commit-colors $(git rev-parse HEAD)" # more confirmation rewards
)
post_checkout=(
    "mig-alerter(sql): alert-migrations-pending.zsh" # inform that action is needed
)
clean_up=(
    'pyclean: rm **/*.pyc'
    'tmpclean: rm tmp/*artifact*'
)
```

Some things to notice in that file:

- All the hooks/scripts are short and live in a single place
- Each "hook section" is just a Zsh array named for git's conventions
- Each script is a line with a `somename:` "name" prefix, then the eval'd command
- After the "name" is an optional "filter": `mdlint` will only look at `.md` files
- The `linter` and `formatter` are run in parallel by being backgrounded (`&`)
- It doesn't generally matter whether you single- or double-quote commands
- The `$CAPT_CHANGES` is the convenient list of files that are part of the commit
- The `test-suite.py` is a local script not on `path`; Captain figures that out
- It gets put into git at your project-root and is used by all devs on the project
- The last `clean_up` hook isn't a git hook, but you can run it directly with `capt` cli

## User-local additional hooks

Suppose you have even higher personal standards than the rest of your team.
E.g., you have OCD about line length. You can ensure that all of _your_
commits conform by creating another local-only `captlocal.zsh` control file.

``` zsh
pre_commit=( 'line-length-nazi: check-line-length' ... other-custom-checkers... )
```

## Migrating your existing git-hooks

You can either take the plunge and clean up, separate, and move your existing
hooks into `capt.zsh`, OR keep existing git-hooks intact, and just add this to
the bottom of each you care about:

```shell
# exiting pre-commit: .git/hooks/pre-commit
bunch of ad hoc jank
...

which capt >/dev/null && capt $(basename $0) $@
```

## Use Captain directly outside of git

You can run any individual hook with `capt` directly. This can sometimes be
useful for debugging; or convenience, in case you want to use Captain as
something of a task collector.

To run a hook:

``` zsh
capt pre-commit # git standard
## OR
capt my-weird-collection
```

## How to bring Captain to your team

Try using a new hook locally on your own for a while. Once you're confident it
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

[Here](https://github.com/sds/overcommit/blob/master/config/default.yml) is a
list of available hooks in Overcommit for in.
