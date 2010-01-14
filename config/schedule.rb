#set :output, "#{RAILS_ROOT}/log/db_backup_cron_log.log"
every 1.day, :at => '11:55 pm' do
    local_file = File.join(RAILS_ROOT, 'tmp', 'nsn_casetracker.pg_dump')
    command "pg_dump -Ft -b -U sosbox sosbox > #{local_file}"
end
    
every 1.day, :at => '11:59 pm' do
    local_file = File.join(RAILS_ROOT, 'tmp', 'nsn_casetracker.pg_dump')
    command "pg_dump -Ft -b -U sosbox sosbox > #{local_file}"
end
    
