#!/usr/bin/env script/runner
require "simple-daemon"
ENV['RAILS_ENV'] ||= 'production'

class MailDaemon < SimpleDaemon::Base
  SimpleDaemon::WORKING_DIRECTORY = "#{RAILS_ROOT}/tmp"
  
  def self.start
    log_message "Starting Mail Sender at"
    random_seconds = (1..30).to_a
    loop do
      Mail.process(:limit => 15) if Mail.respond_to? :process
      sleep(random_seconds[rand(random_seconds.size)])
    end
  end

  def self.stop
    log_message "Stoping Mail Sender at"
  end
  
  def log_message(msg)
    puts "#{msg} #{Time.now.to_s}"
  end
end

MailDaemon.daemonize
