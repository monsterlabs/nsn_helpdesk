class Admin::PrioritiesController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Priority, :name_space => "admin"
end
