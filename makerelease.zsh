#! /bin/zsh

# This "release process" could be automated with github actions, but this
# script is so simple that I'm not bothering for now. And I still push
# frequent bugs to master, so this explicit manual step for truly tested
# commits is safer.

# Creating releases is useful because eget is able to then install captain and
# all its tools with:
#   % eget micahelliott/captain

suffix=
if [[ -n $1 ]]; then suffix="-$1"; fi

vdt=$(date +v%Y.%m.%d)$suffix
artifact=captain-$vdt.tgz

print "Creating artifact of runnable tools in bin dir: $artifact"
tar czvf $artifact -C bin .

print "Will create and push git tag: $vdt"
read -qk "?Proceed? [y/n] " || exit 1

git tag $vdt
git push origin $vdt

print "You should have already created and pushed a git tag: $vdt"
print "Now manually upload $artifact to https://github.com/MicahElliott/captain/releases"

print "Creating a new release on github"
gh release create $vdt $artifact
