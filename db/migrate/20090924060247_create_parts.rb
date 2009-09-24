class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.references :mail
      t.text :body
      t.string :content_type
      t.string :charset
      t.string :disposition
      t.timestamps
    end
  end

  def self.down
    drop_table :parts
  end
end
