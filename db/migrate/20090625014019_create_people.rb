class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.references :user, :null => false
      t.string     :firstname, :lastname, :job_title
      t.boolean    :gender, :null => false, :default => true
      t.text       :notes
      # FIX IT: Check the follow relationship
      t.references :company, :region
            
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
