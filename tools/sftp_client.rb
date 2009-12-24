#!/usr/bin/env script/runner
require 'rubygems'
require 'net/sftp'
local_file = ARGV[0]
if File.exist? local_file
  filename =  File.basename(local_file)
  Net::SFTP.start('lattice.com.mx', 'alex', :password => 'xela2oo9$') do |sftp|
    remote_dir = "/var/alex/backups/nsn/casetracker"
    remote_file = File.join(remote_dir, "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{filename}")
    sftp.upload! local_file, remote_file
  end
  File.delete local_file  
end
