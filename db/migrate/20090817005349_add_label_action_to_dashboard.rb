class AddLabelActionToDashboard < ActiveRecord::Migration
  def self.up
    add_column :dashboards, :label, :string
    add_column :dashboards, :action, :string
  end

  def self.down
    remove_column :dashboards, :label
    remove_column :dashboards, :action
  end
end
