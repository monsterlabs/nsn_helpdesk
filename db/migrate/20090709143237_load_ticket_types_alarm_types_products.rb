class LoadTicketTypesAlarmTypesProducts < ActiveRecord::Migration
  def self.up
    data_path = RAILS_ROOT + '/db/migrate/data'
    [:ticket_types, :alarm_types, :products].each do |file|
      Fixtures.create_fixtures(data_path, file)
    end
  end

  def self.down
  end
end
