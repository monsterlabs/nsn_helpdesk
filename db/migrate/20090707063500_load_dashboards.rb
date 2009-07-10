class LoadDashboards < ActiveRecord::Migration
  def self.up
    # Dashboard for admin
    @admin_role = Role.find_by_name('admin')
    [:tickets, :users, :catalogs].each do |item|
      Dashboard.create(:controller => item.to_s, :role_id => @admin_role.id)
    end
    
    # Fix It: This should support recursivity to add different childs using different levels
    [:failures, :priorities, :regions, :statuses].each do |item|
        @child = Dashboard.create!(:controller => item.to_s, :role_id => @admin_role.id, :parent_id => Dashboard.find_by_role_id_and_controller(@admin_role.id, 'catalogs').id )
    end

    # Dashboard for operator
    [:tickets].each do |item|
      Dashboard.create(:controller => item.to_s, :role_id => Role.find_by_name('operator').id )
    end
    
  end

  def self.down
  end
end
