require File.join(File.dirname(__FILE__), "..", "config", "environment")
require "simple-daemon"
ENV['RAILS_ENV'] = 'production'
class MailDaemon < SimpleDaemon::Base
  SimpleDaemon::WORKING_DIRECTORY = "#{RAILS_ROOT}/tmp"

  def self.start
    seconds = (20..60).to_a
    loop do
      Mail.process(:limit => 15)
      sleep(seconds[rand(seconds.size)])
    end
  end

  def self.stop
  end
end
MailDaemon.daemonize
