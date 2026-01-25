require 'logger'  # ← 2025/06/29これを最上部に追加

# --- Psych(YAML) alias enable for Ruby 3.2 (no recursion) ---
require "psych"

if Psych.respond_to?(:safe_load)
  class << Psych
    # 既存メソッドを別名に退避（これが「元の safe_load」になる）
    alias_method :safe_load_without_aliases, :safe_load

    # safe_load を上書き（必ず退避した方を呼ぶので再帰しない）
    def safe_load(yaml, *args, **kwargs)
      kwargs[:aliases] = true 
      safe_load_without_aliases(yaml, *args, **kwargs)
    end
  end
end
# --- /Psych(YAML) alias enable ---

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require "psych"
Psych::DEFAULT_OPTIONS[:aliases] = true if Psych.const_defined?(:DEFAULT_OPTIONS)

# require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
