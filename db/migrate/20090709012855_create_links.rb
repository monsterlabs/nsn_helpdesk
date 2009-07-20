class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.references :region, :city
      t.references :site_a, :class_name => 'Site'
      t.references :site_b, :class_name => 'Site'
      t.string     :time_zone
      t.text       :other
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
