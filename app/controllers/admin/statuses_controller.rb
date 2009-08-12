class Admin::StatusesController < ApplicationController
  super_scaffold :class_name => Status, :name_space => "admin"
end 