
#!/usr/bin/env bash
set -o errexit
set -o pipefail

echo "Ruby: $(ruby -v)"

# Gemfile.lock に合わせて Bundler 2.5.22 を使用
if ! gem list -i bundler -v 2.5.22 >/dev/null 2>&1; then
  echo "Installing bundler 2.5.22..."
  gem install bundler -v 2.5.22 --no-document
fi

echo "Bundler: $(bundle _2.5.22_ -v)"

bundle _2.5.22_ config set without 'development test'
bundle _2.5.22_ install

yarn install --frozen-lockfile

bundle exec rake assets:precompile
bundle exec rake assets:clean