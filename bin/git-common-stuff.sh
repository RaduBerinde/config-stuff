get_current_branch() {
   #   NAME=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
   local REF NAME
   REF=`git symbolic-ref -q HEAD`
   NAME=${REF##refs/heads/}

   echo $NAME
}

get_product_branch() {
   git config --get remote.origin.url | sed 's/.*\/\([a-zA-Z0-9_-]*\)\.git$/\1/'
}

get_p4_cl() {
   git log -1 $1 | sed -n 's/.*\[git-p4: depot-paths.*change = \([0-9]*\).*/\1/p'
}

error() {
   echo $1 >&2
   exit 1
}


#get_upstream_branch() {
#   local REF UPSTREAM
#   REF=`git symbolic-ref -q HEAD`
#   UPSTREAM=`git for-each-ref --format='%(upstream:short)' "$REF"`
#   [ "$UPSTREAM" == "" ] && UPSTREAM="HEAD"
#   echo "$UPSTREAM"
#}

# Returns the list of release branches from origin (origin/release-*), ordered
# by version (higher version numbers first).
get_release_branches() {
  # We sort by the minor version first, followed by a stable sort on the major
  # version.
  git branch -r --format='%(refname)' \
    | sed 's/^refs\/remotes\///' \
    | grep '^origin\/release-*' \
    | sort -t. -k2 -n -r \
    | sort -t- -k2 -n -r -s
}

# Returns the number of commits in the curent branch that are not shared with
# the given branch.
get_branch_distance() {
  git rev-list --count $1..HEAD
}

# Returns the branch among origin/master, origin/release-* which is the
# closest to the current HEAD.
#
# Suppose the origin looks like this:
#
#                e (master)
#                |
#                d       w (release-19.2)
#                |       |
#                c       u
#                 \     /
#                  \   /
#                   \ /
#                    b
#                    |
#                    a
#
# Example 1. PR on master on top of d:
#
#      e (master)   pr
#             \     /
#              \   /
#               \ /
#                d       w (release-19.2)
#                |       |
#                c       u
#                 \     /
#                  \   /
#                   \ /
#                    b
#                    |
#                    a
#
# The pr commit has distance 1 from master and distance 3 from release-19.2
# (commits c, d, and pr); so we deduce that the upstream branch is master.
#
# Example 2. PR on release-19.2 on top of u:
#
#                e (master)
#                |
#                d   w (release-19.2)
#                |     \
#                |      \   pr
#                |       \ /
#                c       u
#                 \     /
#                  \   /
#                   \ /
#                    b
#                    |
#                    a
#
# The pr commit has distance 2 from master (commits u and w) and distance 1 from
# release-19.2; so we deduce that the upstream branch is release-19.2.
#
# If the PR is on top of the fork point (b in the example above), we return the
# release-19.2 branch.
#
# Example 3. PR on even older release
#
#                e (master)
#                |
#                d    w (release-19.2)
#                |       |
#                |       |
#                |       |        pr
#                c       u       /
#                 \     /       y (release-19.1)
#                  \   /       /
#                   \ /       /
#                    b       x
#                     \     /
#                      \   /
#                       \ /
#                        a
#
# The pr commit has distance 3 from both master and release-19.2 (commits x, y,
# pr) and distance 1 from release-19.1. In general, the distance w.r.t. all
# newer releases than the correct one will be equal; specifically, it is the
# number of commits since the fork point of the correct release (the fork point
# in this example is commit a).
#
get_upstream_branch() {
  local UPSTREAM DISTANCE D

  UPSTREAM="origin/master"
  DISTANCE=$(get_branch_distance origin/master)

  # Check if we're closer to any release branches. The branches are ordered
  # new-to-old, so stop as soon as the distance starts to increase.
  for branch in $(get_release_branches); do
    D=$(get_branch_distance $branch)
    # It is important to continue the loop if the distance is the same; see
    # example 3 above.
    if [ $D -gt $DISTANCE ]; then
      break
    fi
    UPSTREAM=$branch
    DISTANCE=$D
  done

  echo "$UPSTREAM"
}

#
#
#get_upstream_branch() {
#   local REF UPSTREAM
#   REF=`git symbolic-ref -q HEAD`
#   UPSTREAM=`git for-each-ref --format='%(upstream:short)' "$REF"`
#   [ "$UPSTREAM" == "" ] && UPSTREAM="HEAD"
#   echo "$UPSTREAM"
#}

#get_base_branch() {
#   UPSTREAM=`git for-each-ref --format='%(upstream:short)' refs/heads/master`
#   [ "$UPSTREAM" == "" ] && UPSTREAM="master"
#   echo "$UPSTREAM"
#}


## Returns the first branch that exists:
##   1. origin/develop
##   2. origin/master
##   3. radu/master
#get_base_branch() {
#    if git rev-parse --verify -q origin/develop >/dev/null; then
#        if git rev-parse --verify -q origin/master >/dev/null; then
#            # Choose between develop and master
#            NUM_D=`git log --oneline origin/develop..HEAD | wc -l`
#            NUM_M=`git log --oneline origin/master..HEAD | wc -l`
#            if [ $NUM_D -le $NUM_M ]; then
#                echo "origin/develop"
#            else
#                echo "origin/master"
#            fi
#        else
#            echo "origin/develop"
#        fi
#    elif git rev-parse --verify -q origin/master >/dev/null; then
#        echo "origin/master"
#    else
#        echo "radu/master"
#    fi
#}

SHOWCLFMTARGS="--color --graph --oneline --decorate"
COL0="\e[0;33m"
COL1="\e[1;31m"
COL2="\e[1;33m"
COLGR="\e[1;32m"
COLn="\033[0m"

function show_with_tag {
   last=`git log -1 $SHOWCLFMTARGS $1` echo -e "$last ${COL0}(${COL2}$2${COL0})${COLn}"
}
