#! /bin/zsh

# This "release process" could be automated with github actions, but this
# script is so simple that I'm not bothering for now. And I still push
# frequent bugs to master, so this explicit manual step for truly tested
# commits is safer.

# Creating releases is useful because eget is able to then install captain and
# all its tools with:
#   % eget micahelliott/captain

dt=$(date +%Y%m%d)
artifact=captain-v$dt.tgz

print "Creating artifact of runnable tools in bin dir: $artifact"
tar czvf $artifact -C bin .

print "You should have already created a git tag: v$dt"
print "Now manually upload $artifact to https://github.com/MicahElliott/captain/releases"
