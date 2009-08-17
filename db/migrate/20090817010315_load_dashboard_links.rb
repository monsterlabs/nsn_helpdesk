class LoadDashboardLinks < ActiveRecord::Migration
  def self.up
    if ENV['RAILS_ENV'] != 'test'
      @field_manager_role = Role.find_by_name('field_manager')
      Dashboard.create!(:controller => 'tickets', :action => 'mine', :role_id => @field_manager_role, :parent_id => Dashboard.find_by_role_id_and_controller(@field_manager_role, 'tickets').id)
      Dashboard.create!(:label => :all_tickets.to_s.humanize, :controller => 'tickets', :role_id => @field_manager_role, :parent_id => Dashboard.find_by_role_id_and_controller(@field_manager_role, 'tickets').id)
    end
  end

  def self.down
    
  end
end
