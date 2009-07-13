class Admin::RegionsController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Region, :name_space => "admin"
end
