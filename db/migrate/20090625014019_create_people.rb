class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.references :user, :null => false
      t.string     :firstname, :lastname1, :null => false
      t.string     :lastname2
      t.boolean    :gender#,             :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => "moduser_id"
      # Plugin requirement: attributes required by paperclip
      t.string     :photo_file_name, :photo_content_type
      t.integer    :photo_file_size
      t.timestamp  :photo_updated_at
      # /Plugin requirement
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
