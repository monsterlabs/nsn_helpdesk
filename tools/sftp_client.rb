#!/usr/bin/env ruby
require 'rubygems'
require 'net/sftp'
require 'date'
require 'yaml'

class SftpClient
  def initialize
    @datetime = Time.now
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/sftp.yml'))
    @sftp = Net::SFTP.start(@config['host'], @config['username'], :password => @config['password']) 
  end

  def upload_file(local_file)
    if File.exist? local_file
      @sftp.upload! local_file, File.join(@config['remote_dir'], "#{@datetime.strftime('%Y%m%d%H%M%S')}_#{File.basename(local_file)}")
      File.delete local_file
    end
  end

  def remove_old_files(regexp)
    remote_dir = @config['remote_dir']
    @sftp.dir.glob(remote_dir,regexp) do |entry|
      remote_file = entry.name
      @sftp.remove! File.join(remote_dir, remote_file) if DateTime.parse(remote_file.split('_').first) < eval(@config['time_limit'])
    end
  end
end

@ftp_client = SftpClient.new
@ftp_client.upload_file(ARGV[0])
@ftp_client.remove_old_files('*.pg_dump*')
