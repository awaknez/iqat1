#!/usr/bin/env bash
set -o errexit
set -o pipefail

echo "Ruby: $(ruby -v)"

# Render環境で bundler 2.7.x が選ばれて落ちるのを避けるため、Rails6 + Ruby3.1で動く bundler を明示
echo "Installing bundler 2.1.4..."
gem install bundler -v 2.1.4 --no-document

echo "Bundler:"
bundle _2.1.4_ -v

# gems install
bundle _2.1.4_ config set without 'development test'
bundle _2.1.4_ install --jobs 4 --retry 3

# JS deps (webpacker)
yarn install --frozen-lockfile

# assets
bundle _2.1.4_ exec rake assets:precompile
bundle _2.1.4_ exec rake assets:clean
