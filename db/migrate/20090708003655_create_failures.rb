class CreateFailures < ActiveRecord::Migration
  def self.up
    create_table :failures do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :failures
  end
end
