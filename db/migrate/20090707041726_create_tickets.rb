class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string     :subject, :null => false
      t.text       :body
      t.references :link # Links:  :frequency_tx, :frequecy_rx
      t.references :opened_by, :class_name => 'User'
      t.references :assigned_to, :class_name => 'User'
      t.references :reported_by, :class_name => 'User'
      t.references :region, :class_name => 'Region', :null => false
      t.references :priority, :status, :null => false
      t.references :ticket_type, :null => false
      t.timestamps # Opened_date, Resolved_date
    end
  end

  def self.down
    drop_table :tickets
  end
end
