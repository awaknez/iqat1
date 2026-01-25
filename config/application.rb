require_relative 'boot'

require 'rails/all'

# --- Psych(YAML) alias enable (Ruby 3.2+) ---
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

require 'logger'  # ← 2025/06/29 この行を追加

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Iqat1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end