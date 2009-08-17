class AddModifiedByAlternateContactToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :modified_by_id, :integer
    add_column :tickets, :alternate_contact_id, :integer
  end

  def self.down
    remove_column :tickets, :modified_by_id
    remove_column :tickets, :alternate_contact_id
  end
end
