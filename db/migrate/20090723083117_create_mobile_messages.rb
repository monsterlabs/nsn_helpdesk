class CreateMobileMessages < ActiveRecord::Migration
  def self.up
    create_table :mobile_messages do |t|
      t.string :phone_number
      t.text :body
      t.references :ticket
      t.boolean :status
      t.timestamps
    end
  end

  def self.down
    drop_table :mobile_messages
  end
end
