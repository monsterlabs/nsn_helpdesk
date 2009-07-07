class Admin::PrioritiesController < ApplicationController
  filter_access_to :all
  super_scaffold :model => "Priority", :name_space => "admin"
end
