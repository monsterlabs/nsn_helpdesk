class Admin::RegionsController < ApplicationController
  filter_access_to :all
  super_scaffold :model => "Region", :name_space => "admin"
end
