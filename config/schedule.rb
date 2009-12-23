#set :output, "#{RAILS_ROOT}/log/db_backup_cron_log.log"
every 1.day, :at => '11:59 pm' do
    dump_file = Time.now.strftime("%Y%m%d%H%M%S") + '_nsn_casetracker.pg_dump'
    local_file = File.join(RAILS_ROOT, 'tmp', dump_file)
    command "pg_dump -Ft -b -U sosbox sosbox > #{local_file}"
    command "ruby #{RAILS_ROOT}/tools/sftp_client.rb #{local_file}"
    command "rm #{local_file}"
end
    
