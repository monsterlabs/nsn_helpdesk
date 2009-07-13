class Admin::StatusesController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Status, :name_space => "admin"
end