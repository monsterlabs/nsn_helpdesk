class Admin::TicketTypesController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => TicketType, :name_space => "admin", :columns => {:name=> 'string'}
end