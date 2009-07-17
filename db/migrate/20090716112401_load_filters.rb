require 'active_record'
require 'active_record/fixtures'
class LoadFilters < ActiveRecord::Migration
  def self.up
    data_path = RAILS_ROOT + '/db/migrate/data'
      Fixtures.create_fixtures(data_path, :filters)
  end

  def self.down
  end
end
