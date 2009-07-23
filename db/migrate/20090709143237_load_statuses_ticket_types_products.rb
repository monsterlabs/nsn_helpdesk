class LoadStatusesTicketTypesProducts < ActiveRecord::Migration
  def self.up
    if ENV['RAILS_ENV'] != 'test'
    data_path = RAILS_ROOT + '/db/migrate/data'
    [:statuses, :ticket_types, :products].each do |file|
      Fixtures.create_fixtures(data_path, file)
    end
    end
  end

  def self.down
    if ENV['RAILS_ENV'] != 'test'
      Status.destroy_all
      TicketType.destroy_all
      Product.destroy_all
    end
  end
end
