class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.references :region, :city
      t.text       :sites
      t.string     :time_zone
      t.text       :other
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
