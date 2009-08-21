#!/usr/bin/env script/runner
require "simple-daemon"
ENV['RAILS_ENV'] ||= 'production'

class MailDaemon < SimpleDaemon::Base
  SimpleDaemon::WORKING_DIRECTORY = "#{RAILS_ROOT}/tmp"
  
  def self.start
    puts "Loading mail accounts and mail server list.. " + Time.now.to_s
    file_path = "#{RAILS_ROOT}/config/mail_servers.yml"
    mail_servers = YAML.load_file(file_path).collect { |key, value| value.to_options! }
    seconds = (1..60).to_a
    puts "Starting Mail Sender at " + Time.now.to_s
    loop do
      if Mail.respond_to? :process
        ActionMailer::Base.smtp_settings = mail_servers[rand(mail_servers.size)]
        Mail.process(:limit => 15) 
        Mail.update_all("locked = 'f', tries = 0")
        puts "Sending email at " + Time.now.to_s
      end
      sleep(seconds[rand(seconds.size)])
    end
  end

  def self.stop
    puts "Stoping Mail Sender at " + Time.now.to_s
  end
end
MailDaemon.daemonize
