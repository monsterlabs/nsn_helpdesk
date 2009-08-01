class CreateLinks < ActiveRecord::Migration
  def self.up
    
    create_table :time_zones do |t|
      t.text :name, :null => false      
      t.timestamps
    end
    
    create_table :links do |t|
      t.references :region, :city
      t.text       :sites
      t.text       :frequency_tx, :frequency_rx
      t.string     :current_status # 0 + 0, 1 + 0., 1 + 1
      t.references :time_zone
      t.text       :other
      t.string     :ip_address
      t.timestamps
    end
  end

  def self.down
    drop_table :time_zones, :links
  end
end
