class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      # Data provided by customers
      t.references :reported_by, :class_name => 'User' # The region is an attribute available from user_regions and links tables
      t.references :link
      t.integer    :linkable_id
      t.string     :linkable_type
      
      t.text       :frequency_tx, :frequency_rx      
      t.references :product
      t.references :reported_priority, :class_name => 'Priority'
      t.string     :key # =>  NSNCT.....
      t.text       :failure_description # Problem description
      t.text       :alarm_description  # Alarm description
      t.references :status, :null => false, :default => 1 # Open by default      
      
      # Who is opening this ticket?
      t.string     :ip_address      
      t.references :opened_by, :class_name => 'User'
      t.datetime   :opened_at
      
      # Who was taking the call at nokia?
      t.references :attended_by, :class_name => 'User'
      t.references :priority, :class_name => 'Priority' # Priority suggested by field manager
      
      # After ticket registration
      t.references :assigned_to, :class_name => 'User'
      t.references :ticket_type
      t.timestamps 
    end
  end

  def self.down
    drop_table :tickets
  end
end
