class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :region_id
      t.string :city_id
      t.integer :site_a_id
      t.integer :site_b_id
      t.text :other

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
