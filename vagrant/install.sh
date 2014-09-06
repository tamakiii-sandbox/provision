#!/usr/bin/env sh

DIR_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Declare utility functions
now() { date +'%Y-%m-%d %I:%M:%S'; }

# Check if `gem` is installed
if [[ ! -x $(which gem) ]]; then
  echo "[`now`] ERROR: gem command not found"
  exit 1
fi

# Install `bundle`
if [[ ! -x $(which bundle) ]]; then
  echo "[`now`] NOTICE: Installing 'bundle' by gem"
  echo "[`now`] INFO: gem  - version = `gem --version`"
  echo "[`now`] INFO:      - which = `which gem`"
  echo "[`now`] INFO: ruby - version = `ruby --version`"
  echo "[`now`] INFO:      - which = `which ruby`"
  echo

  # Install
  gem install bundle

  # Rehash
  rehash
  rbenv rehash > /dev/null
fi

# Install packages from Gemfile
bundle install

# Install recipes with Berkshelf
if [[ -d $DIR_ROOT/vendor/cookbooks ]]; then
  echo
  echo "[`now`] NOTICE: Removing Berkshelf cookbooks"
  echo
  rm -rf $DIR_ROOT/vendor/cookbooks
fi
$DIR_ROOT/bin/berks vendor $DIR_ROOT/vendor/cookbooks -b $DIR_ROOT/Berksfile
