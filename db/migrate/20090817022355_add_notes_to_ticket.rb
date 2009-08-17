class AddNotesToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :notes, :text
  end

  def self.down
    remove_column :tickets, :notes
  end
end
