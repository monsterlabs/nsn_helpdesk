class CreateUserRoles < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t|
      t.references :user, :role
      t.timestamps
    end
  end

  def self.down
    drop_table :user_roles
  end
end
