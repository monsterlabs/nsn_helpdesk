class TicketType < ActiveRecord::Base
  add_controller_routes
  has_many :tickets
end
