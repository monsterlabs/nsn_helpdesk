class Admin::TicketTypesController < ApplicationController
  filter_access_to :all
  super_scaffold :model => "TicketType", :name_space => "admin", :columns => {:name=> 'string'}
end