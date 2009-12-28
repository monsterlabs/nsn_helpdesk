#!/usr/bin/env script/runner
require 'rubygems'
require 'net/sftp'
require 'date'
require 'yaml'

module SftpClient
  def load_config
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/sftp.yml'))
  end

  def sftp_connection
    load_config
    @sftp = Net::SFTP.start(@config['host'], @config['username'], :password => @config['password']) 
  end

  def upload_file(local_file, datetime)
    if File.exist? local_file
      sftp_connection.upload! local_file, File.join(@config['remote_dir'], "#{datetime.strftime('%Y%m%d%H%M%S')}_#{File.basename(local_file)}")
      File.delete local_file
    end
  end

  def remove_remote_files(datetime)
    sftp_connection
    remote_dir = @config['remote_dir']
    @sftp.dir.glob(remote_dir,'*.pg_dump*') do |entry|
      remote_file = entry.name
      @sftp.remove! File.join(remote_dir, remote_file) if DateTime.parse(remote_file.split('_').first) < eval(@config['time_limit'])
    end
  end
end

include SftpClient
current_datetime = Time.now
SftpClient.upload_file ARGV[0], current_datetime
SftpClient.remove_remote_files current_datetime