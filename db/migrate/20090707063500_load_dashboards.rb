class LoadDashboards < ActiveRecord::Migration
  def self.up
    # Dashboard for admin
    if ENV['RAILS_ENV'] != 'test'
      @admin_role = Role.find_by_name('admin')
      @field_manager_role = Role.find_by_name('field_manager')
      [:tickets, :users, :catalogs, :mobile_messages].each do |item|
        Dashboard.create(:controller => item.to_s, :role_id => @admin_role.id)
      end

      # Fix It: This should support recursivity to add different childs using different levels
      [:companies, :failures, :links, :priorities, :products, :regions, :roles, :statuses, :ticket_types].each do |item|
        @child = Dashboard.create!(:controller => item.to_s, :role_id => @admin_role.id, :parent_id => Dashboard.find_by_role_id_and_controller(@admin_role.id, 'catalogs').id )
      end

      # Dashboard for operator
      [:tickets].each do |item|
        Dashboard.create(:controller => item.to_s, :role_id => Role.find_by_name('operator').id )
      end

      # Dashboard for field_manager
      [:tickets, :users, :links].each do |item|
        Dashboard.create(:controller => item.to_s, :role_id => Role.find_by_name('field_manager').id )
      end
      Dashboard.create!(:label => :my_tickets.to_s.humanize, :controller => 'tickets', :action => 'mine', :role_id => @field_manager_role, :parent_id => Dashboard.find_by_role_id_and_controller(@field_manager_role, 'tickets').id)
      Dashboard.create!(:label => :all_tickets.to_s.humanize, :controller => 'tickets', :role_id => @field_manager_role, :parent_id => Dashboard.find_by_role_id_and_controller(@field_manager_role, 'tickets').id)

      # Dashboard for corporate
      [:tickets].each do |item|
        Dashboard.create(:controller => item.to_s, :role_id => Role.find_by_name('corporate').id )
      end
    end
  end

  def self.down
    if ENV['RAILS_ENV'] != 'test'
      Dashboard.destroy_all
    end
  end
end
