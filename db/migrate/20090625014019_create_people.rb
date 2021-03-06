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
      t.string     :ip_address
      t.references :modified_by, :class_name => 'User'
      t.timestamps
    end

    # create_table :user_regions do |t|
    #   t.references :user, :region, :null => false
    #   t.timestamps
    # end
  end

  def self.down
    drop_table :user_regions
    drop_table :people
  end
end
