class Admin::StatusesController < ApplicationController
  filter_access_to :all
  super_scaffold :model => "Status", :name_space => "admin"
end