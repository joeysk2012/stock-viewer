require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

#uncomment below for local development
#config = YAML.load(File.read(File.expand_path('../local_env.yml', __FILE__)))
#config.merge! config.fetch(Rails.env, {})
#config.each do |key, value|
 # ENV[key] = value unless value.kind_of? Hash
#end

module StockViewer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.serve_static_assets = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
