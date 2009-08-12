class Admin::TicketTypesController < ApplicationController
  super_scaffold :class_name => TicketType, :name_space => "admin", :columns => {:name=> 'string'}
end