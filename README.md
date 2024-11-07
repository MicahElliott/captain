# Captain

> _Captain_ is a simple, convenient, transparent opt-in approach to client-
> and CI-side **git-hook management**, with just a single, small,
> dependency-free shell script to download. Suited for sharing across a team,
> extensible for individuals. Supports all
> [common git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
> (and probably more)! Works with Linux, MacOS, BSDs, probably WSL.
> Language-agnositic — no npm, ruby, yaml or anything to wrestle with.

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

## One-minute E-Z Quick-Start Guide if Captain already set up

_(Easy, point your team here.)_

*SITUATION*: Captain was already set up in a repo you use, and you want to
start enabling its checks (AKA triggers). (Or you're a curmudgeon: You won't
be impacted if you do nothing; then `capt` will not be invoked — but you will
miss out on the fun!)

```shell
# Install the capt command (a small zsh script)
cd ~/src # or somewhere like that where you keep clones
git clone https://github.com/MicahElliott/captain  # to get all tooling, easy to update
print 'path+=~/src/captain/bin' >> ~/.zshrc  # or something/somewhere like that
# OR, put that ^^^ into a .envrc file and use https://github.com/direnv/direnv for your proj
# OR, for just the capt script (sufficient for some projects that don't need extra goodies):
# cd /somewhere/on/your/PATH
# wget https://raw.githubusercontent.com/MicahElliott/captain/main/bin/capt && chmod +x capt

# Point git to the new hooks
cd your-project-root # like you always do
git config core.hooksPath .capt/hooks  # THIS IS THE BIGGIE!!
# Make some project file changes, and
git commit # etc, just like always, nothing you do changed except NOW CLEAN CODE
# Captain at yer service! ...
```

_(Note to MacOS users: If you use a git client/IDE that is not started from a
terminal, you'll need to ensure your `PATH` is set to include
`/path/to/captain` by editing `/etc/paths`, as per
[this](https://stackoverflow.com/a/22465399/326516).)_

If there are any "triggers" (linters, formatters, informers, etc) being
invoked that you don't have installed yet, Captain should kindly let you know
more details.

---

OR, if you're looking to be the one to introduce Captain git-hook management to a
project, read on....

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Captain](#captain)
    - [One-minute E-Z Quick-Start Guide (very easy, point your team here)](#one-minute-e-z-quick-start-guide-very-easy-point-your-team-here)
    - [Do I need a hook manager?](#do-i-need-a-hook-manager)
        - [Captain’s key features](#captains-key-features)
    - [Why Captain instead of another hook manager?](#why-captain-instead-of-another-hook-manager)
    - [Installation](#installation)
        - [Sneaking it in](#sneaking-it-in)
        - [Get it all working](#get-it-all-working)
    - [Setup and Configuration](#setup-and-configuration)
        - [Note on External Tools Installation](#note-on-external-tools-installation)
    - [Control File Spec](#control-file-spec)
        - [Trigger Spec](#trigger-spec)
        - [Example Team Control File](#example-team-control-file)
    - [User-local additional hooks](#user-local-additional-hooks)
    - [Settings](#settings)
    - [Sample Run](#sample-run)
    - [Migrating your existing git-hooks](#migrating-your-existing-git-hooks)
    - [Use Captain directly outside of git](#use-captain-directly-outside-of-git)
    - [How to bring Captain to your team](#how-to-bring-captain-to-your-team)
    - [Treasure trove of hooks](#treasure-trove-of-hooks)
    - [Magit Tips](#magit-tips)
    - [Running Hook Scripts in CI](#running-hook-scripts-in-ci)
    - [Troubleshooting](#troubleshooting)
    - [Featured Projects Using Captain](#featured-projects-using-captain)

<!-- markdown-toc end -->

## Do I need a hook manager?

Short answer: Yes!!

_Without a hook manager_, it's challenging to have a single set of checks
(linters, formatters, cleaners, etc) that all developers agree on. Also,
having multiple objectives/tasks in a single hook file gets slow and ugly.
Managers give you organization, concurrency, shortcut facilities, clarity,
consistency, and much more. Over time, you come up with more ideas for things
that can run automatically as checks, and eventually your standard _unmanaged_
hook files get messy.

Take a single `pre-commit` git-hook for example. You’ll want (for all devs on
each commit):

- a variety of tools (linters, formatters, scanners, testers, etc) to be active
- those tools to run on various OSs despite inconsistent deps installed
- selectivity of which files are run against (not the whole code base!)
- timing info of each tool (with slow ones identified)
- consistent and clear output, drawing attention only to problems
- ignorability of some things on some systems

You can’t have all that without a manager — you end up cooking it yourself,
half-baked. And Yes, you can simply set that all up in your CI (and you
should), but you don’t want your devs waiting 15 minutes to see if their
commit passed. Instead, you want them to wait a few seconds for all that to
run locally, maybe in parallel.

You may argue that all these checks should be done automatically by editors
with on-save hooks. But there are a few reasons that often doesn't happen:

- not all developers know how or bother

- some types of checks are difficult to run automatically, or editors don't
  have packages to run such checks
- some checks may be a bit too slow to run frequently in an editor

So in this regard, Captain takes the onus off all the developers’ editors.

### Captain’s key features

Specifically, here are some of **Captain's features** you don't want to have
to invent, write, and/or wrap around every tool you run:

- **Checking for existence** and guiding installation of tool being run
- **Timing** info of each hook run
- **Clear output** made consistent for each tool
- **Files changed** precise detection and control
- **File filtering** by file type/extension
- **Single file organization** of all hook/script specs for whole team to control/use
- **User-Local scripts** support for individual snowflake developer use
- **Built-In** one-word triggers (linters, etc) with pre-defined filters
- **Add-On linters** provided for optional use
- **OS-agnostic** commands
- **Parallel execution** control of each tool
- **Debugging** aids for writing your own new scripts
- **Custom scripts** location for collecting in your repo

You can think of Captain as like moving your fancy CI setup into everyone’s
local control. The output is reminiscent of Github Actions, but way easier to
set up, runs automatically whenever you use git, and delivers the red and
green a kajillion times faster (aim for not more than a couple seconds).

## Why Captain instead of another hook manager?

Compared to [Lefthook](https://github.com/evilmartians/lefthook),
[Husky](https://typicode.github.io/husky/), and
[Overcommit](https://github.com/sds/overcommit), _Captain is_:

- Tiny, transparent, no deps: read and understand the whole code base (one small Zsh file) in minutes
- Simple: workflow is just calling commands or the scripts you already have
- Client-compatible: other managers don't play nice with some git clients (eg, magit)
- Super fast: sensitivity-colored timing details apparent everywhere
- Any terminal (xterm etc): uses unicode indicators instead of emojis, tuned for 80-char display width
- Basic: config is just a `.capt/share.sh` control file with shell arrays of scripts for each hook (no yaml etc)
- Clean, clear, and concise: your standard git-hooks become one-line calls to `capt` (not cluttered messes)
- Fun: get ideas for new triggers and be entertained by the Captain!
- All documentation right here: this readme is all you need
- Language/tool agnostic: don't need npm, yarn/2, gem, pip, etc; works with any code base
- Hands-off: Captain doesn't try to install things for you (see _External Tools Installation_ below)
- Extensible, custom for each dev: run your own triggers in addition to standards

Captain also has most of the features of other managers:

- Shareable: your whole team has a set of common hooks/triggers
- Batteries: vars for which files changed, multi-OS functions, extra built-in hooks
- Customizeable: run triggers in parallel, with verbosity, etc; run from personal dirs or team's

## Installation

It’s worth noting that no one needs to know you’ve enlisted the Captain. You
can do the following steps to put `capt` to work for just yourself to start out
with. You’ll commit a `.capt/` dir with some innocuous tiny files and point
your own `git` config to use the Captain’s hooks instead of the pedestrian
hooks you may have in `.git/hooks`.

### Get it all working

Each developer of your code base is encouraged to install Captain (point them
to the **[One-minute
guide](#one-minute-e-z-quick-start-guide-very-easy-point-your-team-here)**
above), so violations can be caught before code changes go to CI.

1. `git clone https://github.com/MicahElliott/captain`
1. Try it out! Add your project/company to the
   [Featured Projects](#featured-projects-using-captain) section and run `capt`.
1. Put the `capt` script on your `path`
1. `cd your-project`
1. Run the for-loop below to create any git-hooks you want
1. Create a `.capt/share.sh` control file (or copy the one below)
1. [optional] Create a `.capt/local.sh` control file for your personal
   additional triggers

The `capt` command is invoked with a single argument: the git-hook to run;
e.g., as `capt pre-commit`; that will run all the pre-commit triggers. You can
optionally run `capt` directly to see/debug output, and then have all of
git-hooks call it.

### Install a few tiny dependencies

See `install.zsh` for a scripted solution to installing some dependency tooling.

#### Mac requirements

Install [GNU tools](https://apple.stackexchange.com/a/69332/327065)

```
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
```

## Setup and Configuration

Say you want to enable some git-hooks. Here's how you would create the them,
just like you may have done in the past with git. This step can be done by
each developer upon cloning the project repo:

```shell
## If you want to commit the hooks to repo, and everyone sets hooksPath
hookdir=.capt/hooks
mkdir -p $hookdir
git config core.hooksPath $hookdir
## OR, use git's default location, not in repo; everyone has to do the hook creation
# hookdir=.git/hooks
## Create the standard executable git hook files
for hookfile in pre-commit prepare-commit-msg commit-msg post-commit post-checkout pre-push post-rewrite; do
    echo 'capt $(basename $0) $@' > $hookdir/$hookfile
    chmod +x $hookdir/$hookfile
done
```

Now your `$hookdir` looks like this:

```text
.capt/hooks/  # or .git/hooks/
├── commit-message
├── post-checkout
├── post-commit
├── post-rewrite
└── pre-commit
└── pre-commit-msg
└── pre-push
```

And each of those just contains a one-line invocation of the `capt` command.
That enables git to do its default thing: next time you (or anyone) does a
`git commit`, git will fire its default `pre-commit` script (you just created
that) which calls `capt` with git's args. Then `capt` does its job of finding
the `.capt/share.sh` control file (and optionally `.capt/local.sh`) that you
created.

Now you can put all those trivial one-liner git-hooks into your project's
repo:

```shell
echo '.capt/local.sh' >>.gitignore # discussed below
git add .capt
git commit -m 'Add capt-driven git hooks etc (PSA: install capt and set hooksPath)'
```

That saves all your fellow developers from having to do anything but set: `git
config core.hooksPath $hookdir`, and you can simply point to the
[One-minute](#one-minute-e-z-quick-start-guide-very-easy-point-your-team-here)
instructions above.

### Note on External Tools Installation

It is outside Captain's scope to install all your team's trigger tools on
every dev's machine. However, this repo provides an [example
script](install-standard-triggers.zsh) that should demonstrate common practice
for teams, to get everyone on the same page. Basically, a project should have
a script (or at least a doc) for getting all the tooling installed. It might
be just a bunch of dnf/apt-get/pacman/brew commands, or it could even be an
ansible file.

## Usage

The `capt` CLI has a few built-in commands, such as `help`, `edit` (open
editor on control files), `list` (see active hooks), and more. Use `help` to
see them all and their documentation.

## Control File Spec

Now onto the simple `.capt/share.sh` control file at the root of your repo
(which should also be committed), containing a set of "triggers" for each hook.
(Note that git-hooks purposes are written about
[here](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks).)

### Trigger Spec

There is a tiny DSL that is used to specify each "trigger" in a control file.
Here's an example of a custom trigger. The first part, up to the colon is the
name and optional glob filter. The second part is the command to run, and a
trailing comment docstring. This one says to run the `clj-kondo` linter (named
`lint` in the output) specifically on Clojure files that were changed as part
of the staged commit.

```
    'lint(clj|cljs):   clj-kondo $CAPT_FILES_CHANGED &   ## lint clojure files'
     ^^^^ ^^^^^^^^     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ^   ^^^^^^^^^^^^^^^^^^^^^
     NAME  FILTERS             COMMAND         CONCURRENCY  COMMENT
```

And here's a couple built in triggers. Built-ins have pre-defined commands,
filters, and docs. Note that there is no colon after the name spec for
built-ins. The quotes are optional, but needed if you include a filter. The
first says to run the "whitespace checker" on Ruby, Clojure, and Javascript
files only. The second runs the standard Clojure linter (`clj-kondo`) on all
staged Clojure files.

```
    'wscheck(rb|clj|js)'
    cljlint
```

Note that this syntax looks kinda like the standard [git conventional
commits](https://gist.github.com/qoomon/5dfcdf8eec66a051ecd85625518cfd13) DSL.

### Example Team Control File

```shell
### Captain git-hook manager control file

# params: NONE
# Common hook with several triggers for linting, formatting, and running tests
pre_commit=(
    'lint:             clj-kondo $CAPT_CHANGES &' # linting of files being committed
    'format(clj|cljc): cljfmt &'                  # reformat or check for poor formatting
    'fixmes:           git-confirm.sh'            # look for/prompt on FIXMEs etc
    mdlint                                        # built-in config with implicit md filter
    'wslint(py|sql)'                              # built-in with py and sql file filter
    'test-suite:       run-minimal-test-suite $CAPT_CHANGES'
)
# params: tmp-message-file-path, commit-type, sha
# Build a commit message based on branch name standardized format.
prepare_commit_msg=(
    # you/TEAM-123_FIX_lang_undo-the-widget-munging => fix(lang): Undo the widget munging #123
    br2msg
)
# params: tmp-message-file-path
# Validate your project state or commit message before allowing a commit to go through
commit_msg=(
    '-commitlint: msglint $GITARG1'  # ensure log message meets standards
)
# params: NONE
# Examples: moving in large binary files that you don’t want source
# controlled, auto-generating documentation, etc
# General informative notices, no parameters
post_commit=(
    "stimulate: play-post-commit-sound.sh"           # happy music on successful commit
    "colorize:  commit-colors $(git rev-parse HEAD)" # more confirmation rewards
)
# params: command that triggered rewrite, plus stdin for list of rewrites
# Run by commands that replace commits, (amend/rebase); same uses as post-checkout, post-merge
post_rewrite=(
)

# params: NONE
# Set up your working directory properly for your project environment
post_checkout=(
    "migalert(sql): alert-migrations-pending.zsh" # inform that action is needed
)
# Use to validate a set of ref updates before a push occurs
pre_push=(
)
# Not a git hook!
clean_up=(
    'tmpclean: rm **/*.tmp'
    'artclean: rm tmp/*artifact*'
)


# IDEA: maybe let user specify install recipes
installables=(
    'splint(linux)' 'bbin splint'
    'splint(macos)' 'brew install splint'
)

```

Some things to notice in that file:

- All the triggers are short and live in a single place
- Each "hook section" is just a shell array named for git's conventions (but underscores)
- Some triggers are a line with a `somename:` "name" prefix, then the eval'd command
- After a `name` is an optional "filter": `cljfmt` will only look at `.clj` and `.cljc` files
- The `lint` and `format` are run in parallel by being backgrounded (`&`)
- The `commitlint` is prefixed with a `-`: this instructs Captain to let itxs proceed even if it fails
- You generally should use single-quote commands, even with env vars
- The `$CAPT_CHANGES` is the convenient list of files that are part of the commit
- The `$GITARG1` is the first available param passed from git to a hook script
- The `test-suite` is a local script (in `.capt/scripts/`) not on `path`; Captain figures that out
- `.capt/share.sh` gets put into git at your project-root and is used by all devs on the project
- The last `clean_up` hook isn't a git hook, but you can run it directly with `capt` cli

## User-local additional hooks

Suppose you have even higher personal standards than the rest of your team.
E.g., you have OCD about line length. You can ensure that all of *your*
commits conform by creating another local-only `.capt/local.sh` control file:

``` shell
pre_commit=( 'line-length-pedant: check-line-length' ...other-custom-triggers... )
```

Then you should add `.capt/local.sh` to your `.gitignore` file.

## Settings

You can fine-tune Captain’s behavior with several environment variables.

- `CAPT_VERBOSE` :: Unset to disable subcommand output and docstrings
- `CAPT_DISABLE` :: Set to `1` to bypass captain doing anything
- `CAPT_DEBUG` :: Set to `1` to enable debug mode
- `CAPT_INTERACTIVE` :: Set to `1` to enable interactive continuation mode in non-dumb terminals (progress past errors)
- `CAPT_BLACK_TRIGGERS` :: Set to CSV string of individual triggers you wish to disable
- `CAPT_BLACK_HOOKS` :: Set to CSV string of individual hooks you wish to
  disable
- `CAPT_FILES_OVERRIDE` :: Set to list of files to run on (instead of git-staged)
- `CAPT_MAIN_BRANCH` :: Useful for running in CI since default will be feature branch
- `CAPT_FILE` :: Team-shared control file containing global hooks/triggers
- `CAPT_LOCALFILE` :: User-local personal control file each dev may have (not in git control)
- `CAPT_HOOKSDIR` :: Defaults to `.capt/hooks`, for pointing `git` to
- `CAPT_SCRIPTSDIR` :: Defaults to `.capt/scripts`, for storing team-shared triggers

There are also arrrgs you can utilize from your control files:

- `CAPT_FILES_CHANGED` :: Array of files changed on branch
- `GIT_ARG1` :: First arg git sends to hook
- `GIT_ARG2` :: Second arg git sends to hook
- `GIT_ARG3` :: Third arg git sends to hook

## Sample Run

Rather than a live demo, here's an example of a `git commit` run (doesn't
correspond to triggers shown above). This shows a couple of team-shared checks
(clj-kondo and fixmes).

```text
% git commit

----------------------------------------
(◕‿-) ☠☠☠ PRE-COMMIT ☠☠☠ [◷ 07:01:51] [⎇ mde/SCRUM-54599_feat_ibc_ignore-test-projects] [Δ(4) adr/template.md …sql/billcov-queries.sql …finops/billcov.clj …finops/loan_treatment.clj]

(◕‿-) ☁☁☁ .capt/share.sh ☁☁☁ [⚳ echo nlcheck huglint cljlint cljfmt cljtest mdlint]
(◕‿-) ⚳⚳⚳ ECHO     ♦ [4] .......... SURVIVAL! (⧖ 6ms)
(◕‿-) ⚳⚳⚳ NLCHECK  ♠ [4] .......... SURVIVAL! (⧖ 24ms)
(◕‿-) ⚳⚳⚳ HUGLINT  ♠ [1] .......... SURVIVAL! (⧖ 31ms)
(◕‿-) ⚳⚳⚳ CLJLINT  ♠ [2] .......... SURVIVAL! (⧖ 226ms)
(◕‿-) ⚳⚳⚳ CLJFMT   ♠ [2] .......... SURVIVAL! (⧖ 335ms)
(◕‿-) ⚳⚳⚳ CLJTEST  ♠ [2] .......... SURVIVAL! (⧖ 10ms)
(◕‿-) ⚳⚳⚳ MDLINT   ♠ [1] .......... SURVIVAL! (⧖ 363ms)
(◕‿-) ⚑⚑⚑ Ye survived the barrage. Musta been a fluke. ⚑⚑⚑

(◕‿-) ☁☁☁ .capt/local.sh ☁☁☁ [⚳ docstring(clj) dumb sleeper hithere]
(◕‿-) ⚳⚳⚳ DOCSTRING  ♥ [2] .......... SURVIVAL! (⧖ 18ms)
(◕‿-) ⚳⚳⚳ SLEEPER    ♣ [∞] .......... SURVIVAL! (⧖ 9ms)
(◕‿-) ⚳⚳⚳ HITHERE    ♣ [∞] .......... SURVIVAL! (⧖ 13ms)
(◕‿-) ⚑⚑⚑ Ye survived the barrage. Musta been a fluke. ⚑⚑⚑

----------------------------------------
(◕‿-) ☠☠☠ PREPARE-COMMIT-MSG ☠☠☠ [◷ 07:01:53] [⎇ mde/SCRUM-54599_feat_ibc_ignore-test-projects] [Δ(4) adr/template.md …sql/billcov-queries.sql …finops/billcov.clj …finops/loan_treatment.clj]

(◕‿-) ☁☁☁ .capt/share.sh ☁☁☁ [⚳ br2msg]
(◕‿-) ⚳⚳⚳ BR2MSG  ♠ [4] .......... SURVIVAL! (⧖ 37ms)
(◕‿-) ⚑⚑⚑ Ye survived the barrage. Musta been a fluke. ⚑⚑⚑
hint: Waiting for your editor to close the file... Waiting for Emacs...
```

## Migrating your existing git-hooks

You can either take the plunge and clean up, separate, and move your existing
hooks into `.capt/share.sh`, OR keep existing git-hooks intact, and just add this to
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
something of a task collector/runner. Just create another array in a control
file (eg, `my-weird-collection`), add triggers to it, and invoke `capt
my-weird-collection`.

To run a hook:

``` shell
capt pre-commit # git standard
## OR
capt my-weird-collection
```

## How to bring Captain to your team

Try using a new hook locally on your own for a while. Once you're confident it
does its thing well, confirm with the team that you're moving it into the
shared `.capt/scripts/` dir. If this is a script that will block their commit
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

## Tooling Tips

### Browser notifications

Try out
[notifier for github](https://github.com/sindresorhus/notifier-for-github)
to get real-time desktop pop-up notifications about your builds completing.

### Magit

Use [page-break-lines](https://github.com/purcell/page-break-lines) for nice,
clear sectioning, turning page-breaks (`^L`) into colored lines. Those lines
can also be navigated with `C-x [` (prev) and `C-x ]` (next). Add
`magit-process-mode` to `page-break-lines-modes` to make them visible in
`magit-process`.

Set environment variables that `capt` will read with `M-x setenv`. Eg, if you
want to enable debug mode, set `CAPT_DEBUG` to `1` with that.

## Running Hook Scripts in CI

So you have all these great hook scripts in `.capt/scripts` now, but do you
also want to run them as part of your Continuous Integration? Well, it can be
done! Captain was originally conceived more as a dev-side tool, but you don't
want to reinvent a bunch of checks to run in CI too, so here is a recipe for
setting up the scripts in CI (specifically [Github
Actions](https://docs.github.com/en/actions), but should work with other CIs
too):

1. install `zsh` (github sorely lacks it) and `capt` during the CI run, OR
1. set the `CAPT_MAIN_BRANCH` when invoking `capt`

My experience is that doing (1) may add ~12 seconds to your CI run (if you
don’t do some package caching, in which case it should be ~1 second). If
that's fine, it could be nice to have the consistency with what you run
locally. Your invocations of those scripts can look like:

```yaml
    # fire all the pre-commit scripts (yes, it's already committed)
    run: CAPT_MAIN_BRANCH=origin/main capt integration
```

See the example
[workflows `capt.yml`](.github/workflows/capt.yml) file.

If you care about optimizing the amount of work the scripts do, you may need
to have them be smart about file filtering (file-name extensions, which files
changed in the commit, etc). In practice, the filtering often isn't too
important with the CI runs, since there you might want to go ahead and run all
your tests and analyzers, etc, over your whole code base anyway.

## Comparing to other hook managers

### Specific comparison to Lefthook

I really like lefthook. It's the most featureful, fastest, and simplest of the
managers I tried to adopt. In the end it has a couple blockers. If you don't
care about these things, you might want to go with lefthook since it has a
real team behind it.

- The golang code base is overall nice, and I like go. But it's huge for the
  simple things it does, weighing in at 10 KLOC and 10 MB executable. I needed
  to hack a couple fixes in but it was painful to get into that code. In the
  end, I concluded it was not hackable, at least not for me.
- It won't play nice with magit-process. This could be magit's fault with supporting
  spawned TTYs, but I couldn't fix it. Most output just wouldn't show up. The
  output that did come through rendered poorly even in terminals with a couple
  fonts that didn't like some of the unicode boxes and emojis.
- The generated hooks files are huge, catering to a dozen platforms, and can't
  be tweaked since they get rewritten whenever a config change is made.
- There are voluminous docs because there is complexity and arguably too many
  features, some of which captain aims to remove.
- I thought the YAML config was ugly and wanted to get away with a tiny DSL.
  In the end, I needed something close to the YAML anyway, and realized there
  was already TOML support. So this was ultimately a non-issue.

## Troubleshooting

If for any reason you need to bypass Captain, set this: `export CAPT_DISABLE=1`

## Featured Projects Using Captain

- [Dividend Finance](https://www.dividendfinance.com/) (Clojure projects)

```text
  \\
   (o>
   //\
___V_/_____
   ||
   ||
```

## License

Copyright © Micah Elliott

Distributed under the Eclipse Public License v2.0. See LICENSE.
