class CreateUserRegions < ActiveRecord::Migration
  def self.up
    create_table :user_regions do |t|
      t.references :user
      t.references :region
      t.timestamps
    end
  end

  def self.down
    drop_table :user_regions
  end
end
