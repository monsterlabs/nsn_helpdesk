# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
   config.load_paths += %W( #{RAILS_ROOT}/clients #{RAILS_ROOT}/lib)

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem 'erector', :lib => 'erector', :version => '0.6.7'
  config.gem 'authlogic'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem "stffn-declarative_authorization", :lib => "declarative_authorization", :source => 'http://gems.github.com'
  config.gem "binarylogic-searchlogic", :lib => 'searchlogic', :source => 'http://gems.github.com'
  config.gem 'airblade-paper_trail', :lib => 'paper_trail', :source => 'http://gems.github.com'
  config.gem 'tzinfo', :lib => 'tzinfo'
  config.gem 'simple-daemon'
  config.gem 'spreadsheet', :lib => 'spreadsheet'
  config.gem 'whenever', :lib => false, :source => 'http://gemcutter.org/'
  
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  if ENV['RAILS_ENV'] == 'production'
    config.active_record.observers = :ticket_observer, :link_observer
  end

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  config.time_zone = 'Mexico City'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  config.action_mailer.sendmail_settings = {
    :arguments => '-i -t -f callcenter@lattice.com.mx',
  }
  sendmail_config = YAML.load_file(RAILS_ROOT + "/config/mail.yml")
  config.action_mailer.sendmail_settings.merge!(sendmail_config['settings'])
  config.action_mailer.default_charset = sendmail_config['charset']
  
end


ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!({
  :default => '%m/%d/%Y %H:%M:%S', 
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%m/%d/%Y %I:%M%p"
})
