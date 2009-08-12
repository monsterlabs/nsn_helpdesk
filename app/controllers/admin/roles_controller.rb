class Admin::RolesController < ApplicationController
  super_scaffold :class_name => Role, :name_space => "admin", :columns => {:name=> 'string'}
end