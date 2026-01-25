require 'logger'  # ← 2025/06/29これを最上部に追加

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require "psych"
Psych::DEFAULT_OPTIONS[:aliases] = true if Psych.const_defined?(:DEFAULT_OPTIONS)

require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
