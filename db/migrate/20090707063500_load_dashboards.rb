class LoadDashboards < ActiveRecord::Migration
  def self.up
    # Dashboard for admin
    if ENV['RAILS_ENV'] != 'test'
      @admin_role = Role.find_by_name('admin')
      [:tickets, :users, :catalogs, :mobile_messages].each do |item|
        Dashboard.create(:controller => item.to_s, :role_id => @admin_role.id)
      end

      # Fix It: This should support recursivity to add different childs using different levels
      [:alarm_types, :companies, :failures, :priorities, :products, :regions, :roles, :statuses, :ticket_types].each do |item|
        @child = Dashboard.create!(:controller => item.to_s, :role_id => @admin_role.id, :parent_id => Dashboard.find_by_role_id_and_controller(@admin_role.id, 'catalogs').id )
      end

      # Dashboard for operator
      [:tickets].each do |item|
        Dashboard.create(:controller => item.to_s, :role_id => Role.find_by_name('operator').id )
      end

      # Dashboard for operator
      [:tickets, :users, :links].each do |item|
        Dashboard.create(:controller => item.to_s, :role_id => Role.find_by_name('field_manager').id )
      end
    end
  end

  def self.down
    if ENV['RAILS_ENV'] != 'test'
      Dashboard.destroy_all
    end
  end
end
