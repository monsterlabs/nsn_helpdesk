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
        region_id = row[0].strip
        city_name = row[2]
        other = nil
        if city_name =~ /R1/
          other = city_name
          city_name = nil
        end
        time_zone = TimeZone.find_by_name(row[6])
        unless city_name.nil?
          city = City.exists?(:name => city_name, :region_id => region_id) ?  City.find_by_name_and_region_id(city_name, region_id) : City.create!(:name => city_name, :region_id => region_id)
          Link.create(:region_id => region_id, :city_id => city.id, :sites => row[1].strip, :time_zone_id => time_zone.id, :frequency_tx => row[3], :frequency_rx => row[4], :current_status => row[5].strip)
        else
          Link.create(:region_id => region_id, :other => other, :sites => row[1].strip, :time_zone_id => time_zone.id )
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
