class ReplacingLabelsOfTicketController < ActiveRecord::Migration
  def self.up
     if ENV['RAILS_ENV'] != 'test'
        Dashboard.find_all_by_controller_and_label('tickets', nil).each do |record|
          created_at = record.created_at
          updated_at = record.updated_at
          record.update_attributes(:label => 'Cases', :created_at => created_at, :updated_at => updated_at)
        end
        Dashboard.find_all_by_controller_and_label('tickets', 'My Tickets').each do |record|
          record.update_attribute(:label, 'My Cases')
        end
        Dashboard.find_all_by_controller_and_label('tickets', 'All Tickets').each do |record|
          record.update_attribute(:label, 'All Cases')
        end
        
      end
  end

  def self.down
  end
end
