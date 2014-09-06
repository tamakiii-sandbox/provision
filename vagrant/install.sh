#!/usr/bin/env sh

DIR_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if `gem` is installed
if [[ ! -x $(which gem) ]]; then
  echo '[ERROR] gem command not found'
  exit 1
fi

# Install `bundle`
if [[ ! -x $(which bundle) ]]; then
  echo "[NOTICE] Installing 'bundle' by gem"
  echo "[INFO] gem  - version: `gem --version`"
  echo "[INFO]      - which: `which gem`"
  echo "[INFO] ruby - version: `ruby --version`"
  echo "[INFO]      - which: `which ruby`"
  echo

  # Install
  gem install bundle

  # Rehash
  rehash
  rbenv rehash > /dev/null
fi

# Install packages from Gemfile
bundle install --binstubs --path=vendor

# Install recipes with Berkshelf
if [[ -d $DIR_ROOT/vendor/cookbooks ]]; then
  echo
  echo "[NOTICE] Removing Berkshelf cookbooks"
  echo
  rm -rf $DIR_ROOT/vendor/cookbooks
fi
bin/berks vendor $DIR_ROOT/vendor/cookbooks
