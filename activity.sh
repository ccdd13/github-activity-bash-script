#!/bin/bash

set -e

#
## Use for demo purposes only!
## To execute just run the following commaind inside a demo repository:
#
# wget https://raw.githubusercontent.com/bobbyiliev/github-activity-bash-script/main/activity.sh
# bash activity.sh
#
## Finllly push your changes to GitHub:
#
# git push origin -f your_branch_name"
#

GITHUB_AUTHOR='ccdd12'
REPONAME='github-activity-bash-script'
ASSET_FILENAME='gh-gen-activity.sh'
SELECTED_UPDATE_FUN="update_ghrelease" # update_ghrelease update_ghrepo update_ghpage

dw_gh_release(){
  echo -n 'https://github.com'$(\
    curl -isL https://github.com/${GITHUB_AUTHOR}/${REPONAME}/releases/latest | \
    grep -Fhi "${ASSET_FILENAME}" | \
    sed  -nEe 's~^\s+<a\shref="(.+)"\srel=.+$~\1~ip'\
  )
}
update_ghrelease(){
  [[ -z "$UPDATE_BIN" ]] && UPDATE_BIN="${HOME}/.local/bin"
  echo OK. updating...
  mkdir -p $UPDATE_BIN
  curl -L $(dw_gh_release) --output $UPDATE_BIN/$ASSET_FILENAME
  chmod u+x $UPDATE_BIN/$ASSET_FILENAME
  echo update saved to $UPDATE_BIN/$ASSET_FILENAME ...
  ls -lah --color=auto $UPDATE_BIN/$ASSET_FILENAME
}
update_ghrepo(){
  [[ -z "$UPDATE_BIN" ]] && UPDATE_BIN="${HOME}/.local/bin"
  echo OK. updating...
  mkdir -p $UPDATE_BIN
  curl -L "https://raw.githubusercontent.com/\
${GITHUB_AUTHOR}/${REPONAME}/main/activity.sh" --output $UPDATE_BIN/$ASSET_FILENAME
  chmod u+x $UPDATE_BIN/$ASSET_FILENAME
  echo update saved to $UPDATE_BIN/$ASSET_FILENAME ...
  ls -lah --color=auto $UPDATE_BIN/$ASSET_FILENAME
}
update_ghpage(){
  [[ -z "$UPDATE_BIN" ]] && UPDATE_BIN="${HOME}/.local/bin"
  echo OK. updating...
  mkdir -p $UPDATE_BIN
  curl -L       https://${GITHUB_AUTHOR}.github.io/${REPONAME}/activity.sh
       --output $UPDATE_BIN/$ASSET_FILENAME
  chmod u+x $UPDATE_BIN/$ASSET_FILENAME
  echo update saved to $UPDATE_BIN/$ASSET_FILENAME ...
  ls -lah --color=auto $UPDATE_BIN/$ASSET_FILENAME
}

if [[ -z "ACTIVITY_BR" ]] ; then
  ACTIVITY_BR="main"
fi
if [[ -z "$MAX_PAST_DAYS" ]] ; then
  MAX_PAST_DAYS=365
fi

while [[ "$#" -gt 0 ]] ; do
  case "$1" in
    --branch|--br|-b)
      ACTIVITY_BR="$2"
      shift
    ;;
    --branch=*)
      ACTIVITY_BR=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    --past|-p)
      MAX_PAST_DAYS="$2"
      shift
    ;;
    --past=*)
      MAX_PAST_DAYS=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    --commit-nb|--nb|-n)
      COMMIT_NB="$2"
      shift
    ;;
    --commit-nb=*|--nb=*)
      COMMIT_NB=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    --commit-max|--max|-m)
      COMMIT_MAX="$2"
      shift
    ;;
    --commit-max=*|--max=*)
      COMMIT_MAX=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    --interactive|-i)
      INTERACTIVE="true"
    ;;
    --gh-author)
      GITHUB_AUTHOR="$2"
      shift
    ;;
    --gh-author=*)
      GITHUB_AUTHOR=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    --reponame)
      REPONAME="$2"
      shift
    ;;
    --reponame=*)
      REPONAME=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    ----asset-fname)
      ASSET_FILENAME="$2"
      shift
    ;;
    --asset-fname=*)
      ASSET_FILENAME=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    --update|-u)
      UPDATE_BIN="${HOME}/.local/bin"
    ;;
    --update=*)
      UPDATE_BIN=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
    --update-fun)
      SELECTED_UPDATE_FUN="$2"
      shift
    ;;
    --update-fun=*)
      SELECTED_UPDATE_FUN=$(echo -n "$1" | tr '=' '\n' | tail -n 1)
    ;;
  esac
  shift
done

if [[ ! -z "$UPDATE_BIN" ]] ; then
  $SELECTED_UPDATE_FUN
  exit
fi

if [[ ! -d ".git" ]] ; then
  >&2 echo NO. NOT git repo. making one...
  cwd=$(pwd)
  dir=$(mktemp -d -p $cwd test-git-repo-XXXXXXXXX)
  mkdir -p $dir
  cd $dir
  git init
fi

# thomas-nyman CC BY-SA 3.0 https://unix.stackexchange.com/a/155077
if [[ -z "$(git status --porcelain)" ]] ; then
  echo OK. Working directory clean...
else
  >&2 echo NO. Working directory NOT clean. Uncommitted changes...
  exit 1
fi

git checkout --orphan $ACTIVITY_BR >/dev/null 2>&1 || \
git checkout $ACTIVITY_BR > /dev/null 2>&1 || echo ok >/dev/null

# Create temp commits direcotry
if [[ ! -d .commits ]] ; then
  mkdir -p .commits
fi

# Add changes file log
if [[ ! -f  .commits/changes ]] ; then
  touch .commits/changes
fi

# Create commits for the past $MAX_PAST_DAYS days
for (( day=$MAX_PAST_DAYS; day>=1; day-- )) ; do
    # Get the past date of the commit
    day2=$(date --date="-${day} day" "+%a, %d %b %Y %X %z")

    echo "Creating commits for ${day}"

    # Generate random number of commits for that date
    if [[ -z "$COMMIT_NB" ]] ; then
      if [[ -z "$COMMIT_MAX" ]] ; then
        commits=$(( ( RANDOM % 6 ) + 2 ))
      else
        commits=$(( ( RANDOM % $COMMIT_MAX ) + 1 ))
      fi
    else
      commits=$COMMIT_NB
    fi

    # Create the comits
    echo "Creating ${commits} commits"
    for ((i=1;i<=${commits};i++)); do
        content=$(date -d "${day2}" +"%s")
        echo ${content}-${i} >> .commits/changes
        git add .commits/changes
        git commit -m "Commit number ${content}-${i}"
        git commit --amend --no-edit --date "${day2}"
    done
done

yes_or_no(){
# author   : tiago-lopo john-kugelman CC BY-SA 3.0 https://stackoverflow.com/a/29436423
# usage    : yes_or_no "$message" && do_something
# modified
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [YyOo]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

if [[ ! -z "$INTERACTIVE" ]] ; then
  if command -v gh ; then
    echo
    echo OK. github cli found.
    yes_or_no "Did you want to create repo on github ? " && \
              gh repo create $(basename $(pwd)) \
                -y \
                --private \
                --description 'generated by https://github.com/ccdd12/github-activity-bash-script' \
                --homepage    'https://github.com/ccdd12/github-activity-bash-script' \
              >/dev/null 2>&1 || \
              echo NO. repo already exist.
  else
    >&2 echo error "'gh'" command not found
  fi
fi

if [[ ! -z "$INTERACTIVE" ]] ; then
  echo
  yes_or_no "Did you want to push to remote 'origin' ? " && \
            git push --force --set-upstream origin $ACTIVITY_BR || \
            echo OK. push to your own remote remote/branch.
fi

cat << EOF



      Generating commits completed...

      To push your changes later :

          git remote add origin https://github.com/username/$(basename $(pwd))

          gh  repo   create
          git push   --force --set-upstream origin $ACTIVITY_BR


EOF
