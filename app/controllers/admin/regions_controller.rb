class Admin::RegionsController < ApplicationController
  super_scaffold :class_name => Region, :name_space => "admin"
end
