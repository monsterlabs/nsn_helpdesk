class CreateDashboards < ActiveRecord::Migration
  def self.up
    create_table :dashboards do |t|
      t.string     :controller
      t.references :role
      t.references :parent, :class_name => 'Dashboard'
      t.timestamps
    end
  end

  def self.down
    drop_table :dashboards
  end
end
