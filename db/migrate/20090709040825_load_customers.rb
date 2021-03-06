require 'rubygems'
require "csv"  
require "declarative_authorization/maintenance"
class LoadCustomers < ActiveRecord::Migration
  def self.up
    if ENV['RAILS_ENV'] != 'test'
      data_path = RAILS_ROOT + '/db/migrate/data'
      %w(customer operator field_manager group_manager corporate).each do |role_name|
        filename = data_path + "/#{role_name}.csv"
        CSV.read(filename).each do |row|
          company_name = row[6].to_s.strip  
          company_name = 'Otro' if company_name.to_s.empty?
          company = Company.exists?(:name=> company_name) ? Company.find_by_name(company_name) : Company.create!(:name => company_name)

          region_name =row[7].to_s.strip  
          region =  region_name.empty? ? nil : (Region.exists?(:name=> region_name) ? Region.find_by_name(region_name) : Region.create!(:name => region_name))

          email = row[2].to_s.strip
          Authorization::Maintenance::without_access_control do
            if User.exists?(:email=>email)
              @user = User.find_by_email(email)
              @user.roles << Role.find_by_name(role_name)
              @user.save

            else

              @user = User.create!(:email => email, :login => email.split('@').first, :password => 'qw12..', :password_confirmation => 'qw12..')

              person_params = { :firstname => row[1].to_s.strip, :lastname => row[0].to_s.strip, :job_title => row[5].to_s.strip, :notes => nil, :company_id => company.id }
              person_params.merge!(:region_id => region.id) unless region.nil?
              #@user.regions << region unless region.nil?
              @user.person_attributes = person_params

              city_name = row[14].to_s.strip
              city = city_name.to_s.empty? ? nil : (City.exists?(:name => city_name, :region_id => region.id) ?  City.find_by_name_and_region_id(city_name, region.id) : City.create!(:name => city_name, :region_id => region.id))
              address_params = { :location => nil, :city_id => nil, :country_id => 484, :state_id => nil, :zipcode => nil, :business_phone => row[8].to_s.strip, :home_phone => row[9].to_s.strip,:mobile_phone => row[10].to_s.strip, :fax_number => nil}
              address_params.merge(:city_id => city.id) unless city.nil?
              @user.address_attributes = address_params

              @user.roles << Role.find_by_name(role_name)

              @user.save
            end
          end
        end
      end
    end
  end

  def self.down
    if ENV['RAILS_ENV'] != 'test'
      City.destroy_all
      Person.destroy_all
      User.destroy_all
      Role.destroy_all
      Region.destroy_all
      Company.destroy_all
    end
  end
end
