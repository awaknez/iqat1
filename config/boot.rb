require 'logger'  # ← 2025/06/29これを最上部に追加

# --- Psych(YAML) alias enable for Ruby 3.2 ---
require "psych"
module Psych
  class << self
    alias_method :_orig_safe_load, :safe_load
    def safe_load(yaml, **kwargs)
      kwargs[:aliases] = true unless kwargs.key?(:aliases)
      _orig_safe_load(yaml, **kwargs)
    end
  end
end
# --- /Psych(YAML) alias enable ---

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require "psych"
Psych::DEFAULT_OPTIONS[:aliases] = true if Psych.const_defined?(:DEFAULT_OPTIONS)

# require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
