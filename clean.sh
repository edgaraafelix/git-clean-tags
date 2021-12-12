#!/bin/sh

red=$'\e[1;31m'
green=$'\e[0;32m'
end=$'\e[0m'

git_dir=".git"
usage="Usage: ./delete.sh -p PATH_TO_DIR"

while getopts ":p:" opt; do
  case $opt in
    p) path="$OPTARG"
    ;;
    \?) 
      printf "%sInvalid option -$OPTARG\n%s" $red $end >&2
      echo $usage
      exit 1
    ;;
  esac
done

if [ "" = "$path" ]; then
  printf "%sInvalid value\n%s" $red $end >&2
  echo $usage
  exit 1
fi

printf "Path=%s\n" $path
printf "Checking directory exists...\n"

if [ ! -d "$path" ]; then
  printf "%sDirectory not found\n%s" $red $end
  exit 1
fi

cd $path

printf "Checking git repository...\n"

if [ ! -d "$git_dir" ]; then
  printf "%sNot a git repository\n%s" $red $end
  exit 1
fi

latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
tag_list=$(git tag -l | grep -v $latest_tag)
old_tags=($tag_list)

printf "Latest tag=%s\n" $latest_tag

if [ "" = "$tag_list" ]; then
  printf "%sFound 0 refs to delete\n%s" $green $end
  exit 1
fi

printf "%sFound ${#old_tags[@]} refs to delete\n%s" $red $end

git push origin --delete $tag_list
git tag -d $(git tag -l)
git fetch

printf "%s\nWoohoo, all done!\n%s" $green $end