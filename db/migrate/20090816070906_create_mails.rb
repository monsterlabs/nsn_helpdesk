class CreateMails < ActiveRecord::Migration
  def self.up
    create_table :mails do |t|
      t.string :subject, :from, :to, :cc, :bcc, :charset, :content_type
      t.text :body, :data
      t.boolean :locked, :default => false, :null => false
      t.integer :priority, :default => 3, :null => false
      t.integer :tries, :default => 0, :null => false
      t.integer :maximum_tries, :default => 3, :null => false
      t.integer :mailable_id 
      t.string  :mailable_type
      t.timestamps
    end
    add_index :mails, :locked
    add_index :mails, :priority
    add_index :mails, :tries
  end

  def self.down
    drop_table :mails
  end
end
