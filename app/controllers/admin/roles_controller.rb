class Admin::RolesController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Role, :name_space => "admin", :columns => {:name=> 'string'}
end