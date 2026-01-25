
#!/usr/bin/env bash
set -o errexit
set -o pipefail

echo "Ruby: $(ruby -v)"

# lockfile に合わせて bundler 2.7.2 を使う
if ! gem list -i bundler -v 2.7.2 >/dev/null 2>&1; then
  echo "Installing bundler 2.7.2..."
  gem install bundler -v 2.7.2 --no-document
fi

echo "Bundler: $(bundle _2.7.2_ -v)"

bundle _2.7.2_ config set without 'development test'
bundle _2.7.2_ install

yarn install --frozen-lockfile

bundle _2.7.2_ exec rake assets:precompile
bundle _2.7.2_ exec rake assets:clean
