# Captain

Captain is a simple and convenient approach to client-side git-hook
management, with just a tiny script to download. Suited for a team, extensible
for individuals.

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

## One-minute quick-start guide

*SITUATION*: Captain was set up in a repo you use, and you want to start
enabling its checks. (You won't be impacted if you do nothing.)

```shell
# point git to the new hooks
git config core.hooksPath .capthooks
# Install the capt command (a small shell script)
cd /somewhere/on/your/PATH
wget https://raw.githubusercontent.com/MicahElliott/captain/main/capt
chmod +x capt
# Make some changes and run git
cd your-project-root
git commit # Captain at yer service! ...
```

If there are any "checkers" (linters, formatters, etc) being invoked that you
don't have installed yet, Captain will kindly let you more details.

## Do I need a hook manager?

Without a hook manager, it's challenging to have a single set of checks
(linters, formatters, cleaners, etc) that all developers agree on. Also,
having multiple objectives/tasks in a single hook file gets slow and ugly.
Managers give you organization, parallelism, shortcut facilities, clarity,
consistency, and more. Over time, you come up with more ideas for things that
can run automatically as checks, and eventually your standard hook files can
get unmanageable and messy.

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

## Why Captain instead of another hook manager?

Compared to [Lefthook](https://github.com/evilmartians/lefthook),
[Husky](https://typicode.github.io/husky/), and
[Overcommit](https://github.com/sds/overcommit), Captain is:

- Simple: workflow is just calling commands or the scripts you already have
- No dependencies: if you have Zsh installed, you're already done
- Client-compatible: other managers don't play nice with some git clients (eg, magit)
- Basic: config is just a `capt.zsh` control file with arrays of scripts for each hook (no yaml etc)
- Clear: your standard git-hooks become one-line calls to `capt`
- Fun: get ideas for new checks and be entertained by the Captain!
- All documentation right here: this readme is all you need
- Tiny and transparent: read and understand the whole code base (one file) in minutes
- Language/tool agnostic: don't need to know npm, yum, gem, pip, etc
- Hands-off: Captain doesn't try to install things for you
- Extensible, custom for each dev: run your own checks in addition to standards

Captain also has most of the features of other managers:

- Shareable: your whole team has a set of common hooks/checks
- Batteries: vars for which files changed, multi-OS functions
- Customizeable: run checks in parallel, with verbosity, etc; run from personal
  dirs or team's

## Installation

Each developer of your code base is encouraged to install Captain, so
violations can be caught before code changes go to CI.

1. Put the `capt` zsh script on your `path`
1. Run the for-loop below to create any git-hooks you want
1. Create a `capt.zsh` control file (or copy the one below)
1. Create a `captlocal.zsh` control file for your personal additional checks (optional)

The `capt` command is invoked with a single argument: the git-hook to run;
e.g., as `capt pre-commit`; that will run all the pre-commit checks. You can
optionally run `capt` directly to see/debug output, and then have all of
git-hooks call it.

## Setup and configuration

Say you want to enable some git-hooks. Here's how you would create the them,
just like you may have done in the past with git. This step can be done by
each developer upon cloning the project repo:

```shell
## If you want to commit the hooks to repo, and everyone sets hooksPath
hookdir=.capthooks
mkdir $hookdir
git config core.hooksPath $hookdir
## OR, use git's default location, not in repo; everyone has to do the hook creation
# hookdir=.git/hooks
## Create the standard executable git hook files
for hookfile in pre-commit commit-message post-checkout post-commit; do
    echo 'capt $(basename $0) $@' > $hookdir/$hookfile
    chmod +x $hookdir/$hookfile
done
```

Now your `$hookdir` looks like this:

```text
.capthooks/  # or .git/hooks/
├── commit-message
├── post-checkout
├── post-commit
└── pre-commit
```

And each of those just contains a one-line invocation of the `capt` command.
That enables git to do its default thing: next time you (or anyone) does a
`git commit`, git will fire its default `pre-commit` script (you just created
that) which calls `capt` with git's args. Then `capt` does its job of
finding the `capt.zsh` control file (and optionally `captlocal.zsh`) that you
created.

Now you can put all those trivial one-liner git-hooks into your project's
repo:

```shell
git add $hookdir
git commit -m 'Add capt-driven git hooks (PSA: install capt and set hooksPath)'
```

That saves all your fellow developers from having to do anything but set:
`git config core.hooksPath $hookdir`, and you can simply point to the
*One-minute* instructions above.

Now onto the simple `capt.zsh` control file at the root of your repo (which
should also be committed), containing a set of "checks" for each hook:

```shell
### Captain git-hook manager control file

# Standard hook with checks for linting, formatting, and running tests
pre_commit=(
    'lint:        clj-kondo $CAPT_CHANGES &' # linting of files being committed
    'format(clj): cljfmt &'                  # reformat or check for poor formatting
    'fixmes:      git-confirm.sh'            # look for/prompt on FIXMEs
    markdownlint                         # built-in config with filter
    'test-suite:  run-minimal-test-suite $CAPT_CHANGES'
)
commit_msg=(
    commitlint  # ensure log message meets standards
)
post_commit=(
    "stimulate: play-post-commit-sound.sh"           # happy music on successful commit
    "colorize:  commit-colors $(git rev-parse HEAD)" # more confirmation rewards
)
post_checkout=(
    "mig-alert(sql): alert-migrations-pending.zsh" # inform that action is needed
)
clean_up=(
    'tmpclean: rm **/*.tmp'
    'artclean: rm tmp/*artifact*'
)
```

Some things to notice in that file:

- All the hooks/checks are short and live in a single place
- Each "hook section" is just a Zsh array named for git's conventions (but underscores)
- Some checks are a line with a `somename:` "name" prefix, then the eval'd command
- After a `name` is an optional "filter": `cljfmt` will only look at `.cljs` and `.clj` files
- The `lint` and `format` are run in parallel by being backgrounded (`&`)
- It doesn't generally matter whether you single- or double-quote commands
- The `$CAPT_CHANGES` is the convenient list of files that are part of the commit
- The `test-suite` is a local script not on `path`; Captain figures that out
- `capt.zsh` gets put into git at your project-root and is used by all devs on the project
- The last `clean_up` hook isn't a git hook, but you can run it directly with `capt` cli

## User-local additional hooks

Suppose you have even higher personal standards than the rest of your team.
E.g., you have OCD about line length. You can ensure that all of *your*
commits conform by creating another local-only `captlocal.zsh` control file as:.

``` zsh
pre_commit=( 'line-length-nazi: check-line-length' ... other-custom-checkers... )
```

Then you should add `captlocal.zsh` to the `.gitignore`.

## Sample run

Rather than a live demo, here's an example of a `pre-commit` run (doesn't
correspond to checks shown above). This shows a couple of team-shared checks
(clj-kondo and fixmes), and then after the parrot, a single user-local
`something` check:

```text
(◕‿-) CAPTAIN IS OVERHAULIN. NO QUARTER!
       _________
      |-_ .-. _-|
      |  (*^*)  |
      |_-"|H|"-_|

(◕‿-) Loadin the gunwales: /home/mde/work/fooproj/capt.zsh

(◕‿-) === PRE-COMMIT ===

(◕‿-) Discoverin yer MAIN branch remotely...
(◕‿-) Main branch bein compared against: master
(◕‿-) Files changed in yer stage (10):
(◕‿-) - base/src/main/clojure/foo/core.clj
(◕‿-) - resources/sql/some-queriees.sql
(◕‿-) - ...
(◕‿-) Execution awaits!
(◕‿-) - clj-kondo
(◕‿-) - fixmes

(◕‿-) ??? CLJ-KONDO ???
(◕‿-) Files under siege: 10
maybe some output from clj-kondo, but assume all is well
(◕‿-) Ahoy! Aimin our built-in cannon with files: $CAPT_FILES_CHANGED
(◕‿-) ✓✓✓ SURVIVAL! (time: 2ms) ✓✓✓

(◕‿-) ??? FIXMES ???
(◕‿-) Ye took care of file selection yerself, or no files needin fer sayin.
(◕‿-) Ahoy! Aimin yer cannon: fixmes: git-confirm.sh
Git-Confirm: hooks.confirm.match not set, defaulting to 'TODO'
Add matches with `git config --add hooks.confirm.match "string-to-match"`
(◕‿-) ✓✓✓ SURVIVAL! (time: 12ms) ✓✓✓

(◕‿-) Ye survived the barrage. Must have been a fluke.

         \
         (o>
      ___(()___
         ||

(◕‿-) Next on the plank: user-local hook scripts
(◕‿-) Loadin the gunwales: /home/mde/work/cc/captlocal.zsh

(◕‿-) Execution awaits!
(◕‿-) - something

(◕‿-) ??? SOMETHING ???
(◕‿-) Ye took care of file selection yerself, or no files needin fer sayin.
(◕‿-) Ahoy! Aimin yer cannon: something: sayhi.zsh
some output from sayhi
(◕‿-) ✓✓✓ SURVIVAL! (time: 3ms) ✓✓✓

(◕‿-) Ye survived the barrage. Must have been a fluke.

(◕‿-) Show a leg!
hint: Waiting for your editor to close the file...
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
list of available hooks in Overcommit for inspiration.

And here is a list of common hooks that any project may want to leverage,
regardless of language:

- [commitlint](https://github.com/conventional-changelog/commitlint)
- [markdownlint](https://github.com/igorshubovych/markdownlint-cli)
- [git-confirm](https://github.com/pimterry/git-confirm): fixmes, etc
- audible notifications
-

```text
  \\
   (o>
   //\
___V_/_____
   ||
   ||
```
