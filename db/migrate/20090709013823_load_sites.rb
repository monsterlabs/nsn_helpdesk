require 'active_record'
require 'active_record/fixtures'
require "csv"  
class LoadSites < ActiveRecord::Migration
  def self.up
    if ENV['RAILS_ENV'] != 'test'
      # It requires rake db:fixtures:load
      data_path = RAILS_ROOT + '/db/migrate/data'
      [:failures, :priorities, :regions, :time_zones].each do |file|
        Fixtures.create_fixtures(data_path, file)
      end
      filename = data_path + '/sites.csv'
      CSV.read(filename).each do |row|
        region_name = row[1].strip
        city_name = row[3]
        other = nil
        if city_name =~ /R1/
          other = city_name
          city_name = nil
        end
        region = Region.exists?(:name => region_name) ? Region.find_by_name(region_name) : Region.create!(:name => region_name)

        unless city_name.nil?
          city = City.exists?(:name => city_name, :region_id => region.id) ?  City.find_by_name_and_region_id(city_name, region.id) : City.create!(:name => city_name, :region_id => region.id)
          Link.create(:region_id => region.id, :city_id => city.id, :sites => row[2].strip )
        else
          Link.create(:region_id => region.id, :other => other, :sites => row[2].strip )
        end
      end
    end
  end

  def self.down
      if ENV['RAILS_ENV'] != 'test'
          City.destroy_all
          Region.destroy_all
          Failure.destroy_all
          Priority.destroy_all
      end
  end
end
