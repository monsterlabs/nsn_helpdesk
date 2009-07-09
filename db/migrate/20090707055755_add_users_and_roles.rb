require 'rubygems'
require "declarative_authorization/maintenance"
class AddUsersAndRoles < ActiveRecord::Migration
  def self.up
    Authorization::Maintenance::without_access_control do
      [:admin, :group_manager, :operator, :customer, :technician].each do |role|
        Role.create(:name => role.to_s)
      end
      Role.create(:name => 'field_manager', :parent_id => Role.find_by_name('group_manager'))
      # Role.create!(:name => 'contact', :parent_id => Role.find_by_name('field_manager'))
      

      pw_admin = 'r00t'
      @admin = User.create!(:login => 'admin', :email => 'admin.lattice@gmail.com', :password => pw_admin, :password_confirmation => pw_admin)
      @admin.roles << Role.find_by_name('admin')

      pw_operator = 'limited'
      @operator = User.create!(:login => 'operator', :email => 'operator.lattice@gmail.com', :password => pw_operator, :password_confirmation => pw_operator)
      @operator.roles << Role.find_by_name('operator')

      puts "== Users " + ("=" * 72)
      puts "login: admin, :password: #{pw_admin}"
      puts "login: operator, :password: #{pw_operator}"
    end
  end

  def self.down
    Authorization::Maintenance::without_access_control do
      %w(admin operator).each do |login|
        u = User.find_by_login(login)
        u.destroy if u
      end
    end
  end
end
