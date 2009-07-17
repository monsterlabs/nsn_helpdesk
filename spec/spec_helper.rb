ENV["RAILS_ENV"] ||= 'test'
require 'rubygems'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require File.expand_path(File.dirname(__FILE__) + "/spec_helpers/controller_spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/spec_helpers/application_spec_helper")
require 'spec/autorun'
require 'spec/rails'
require 'remarkable_rails'
require 'remarkable_activerecord'
require 'authlogic/test_case'
require 'email_spec/helpers'
require 'email_spec/matchers'

Spec::Runner.configure do |config|
  config.include(ControllerSpecHelper, :type => :controller)
  config.include(ApplicationSpecHelper)
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end
