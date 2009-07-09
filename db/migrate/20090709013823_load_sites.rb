require 'active_record'
require 'active_record/fixtures'
require "csv"  
class LoadSites < ActiveRecord::Migration
  def self.up
    # It requires rake db:fixtures:load
    data_path = RAILS_ROOT + '/db/migrate/data'
    [:failures, :priorities, :regions].each do |file|
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
      site_name_a = row[2].split('-').first.strip
      site_name_b = row[2].split('-').last.strip
      region = Region.exists?(:name => region_name) ? Region.find_by_name(region_name) : Region.create!(:name => region_name)

      site_a = Site.exists?(:name => site_name_a) ? Site.find_by_name(site_name_a) : Site.create!(:name => site_name_a)
      site_b = Site.exists?(:name => site_name_b) ? Site.find_by_name(site_name_b) : Site.create!(:name => site_name_b)

      unless city_name.nil?
        city = City.exists?(:name => city_name, :region_id => region.id) ?  City.find_by_name_and_region_id(city_name, region.id) : City.create!(:name => city_name, :region_id => region.id)
        Link.create(:region_id => region.id, :city_id => city.id, :site_a_id => site_a.id, :site_b_id => site_b.id)
      else
        Link.create(:region_id => region.id, :other => other, :site_a_id => site_a.id, :site_b_id => site_b.id)
      end
    end
  end

  def self.down
  end
end
