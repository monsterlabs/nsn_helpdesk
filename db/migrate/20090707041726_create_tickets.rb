class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      # Data provided by customers
      t.references :product
      t.references :reported_by, :class_name => 'User' # The region is an attribute available from user_regions and links tables
      t.references :link # if we save only this field, we will indicating that the 2 sites are failing
      t.string     :affected_site # if we specify this, we will indicate that one site is failing
      
      t.text       :frequency_tx, :frequency_rx
      t.references :reported_priority, :class_name => 'Priority' # Priority suggested by customer
      t.string     :case_id # =>  NSNCTddmmyyyyn
      t.references :failure # Problem description
      t.text       :alarm # Alarm description
      t.text       :special_instructions
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
      #Who accepts ticket closing?
      t.references :accepts_closing, :class_name => 'User'
      t.timestamps 
    end
  end

  def self.down
    drop_table :tickets
  end
end
