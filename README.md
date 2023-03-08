# Captain

Captain is a very simple, worse-is-better approach to git-hook managmement.

## Why Captain instead of X?

Compared to Lefthook, Husky, and Overcommit, Captain is:

- Tiny and transparent: read and understand the whole code base (one file) in minutes
- Simple: workflow is just calling the scripts you probably already have
- No dependencies: if you have Zsh, you're already done
- Compatible: other managers don't play nice with git clients, but Captain does
- Basic: config is just a Zsh file with arrays of scripts for each hook (no yaml etc)
- Clear: your standard git-hooks become one-line calls to `capt`

And just like those others, Captain is also:

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
1. Create a `.capt-loacal` file
1. Point Captain to your team scripts

## Configuration

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
