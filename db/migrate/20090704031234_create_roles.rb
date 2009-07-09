class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :name, :string
      t.references :parent, :class_name => 'Role'
      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
