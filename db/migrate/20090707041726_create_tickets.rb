class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string     :subject, :null => false
      t.text       :body
      t.references :product
      t.references :link
      t.string     :frequency_tx, :frequency_rx
      t.references :opened_by, :class_name => 'User'
      t.references :assigned_to, :class_name => 'User'
      t.references :reported_by, :class_name => 'User'
      t.references :attended_by, :class_name => 'User'
      t.references :region, :class_name => 'Region', :null => false
      t.references :priority, :null => false
      t.references :status, :null => false, :default => 1
      t.references :ticket_type, :null => false
      t.datetime   :opened_at
      t.timestamps # Opened_date, Resolved_date
    end
  end

  def self.down
    drop_table :tickets
  end
end
