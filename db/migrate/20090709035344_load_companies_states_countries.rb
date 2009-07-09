require 'active_record'
require 'active_record/fixtures'
class LoadCompaniesStatesCountries < ActiveRecord::Migration
  def self.up
    # It requires rake db:fixtures:load
    data_path = RAILS_ROOT + '/db/migrate/data'
    [:companies, :countries, :states].each do |file|
      Fixtures.create_fixtures(data_path, file)
    end
  end

  def self.down
  end
end
