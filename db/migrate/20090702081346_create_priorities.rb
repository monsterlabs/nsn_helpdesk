class CreatePriorities < ActiveRecord::Migration
  def self.up
    create_table :priorities do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :priorities
  end
end
