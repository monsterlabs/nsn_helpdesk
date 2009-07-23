class Admin::PrioritiesController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Priority, :name_space => "admin", :columns => { :name => 'string', :time_limit => 'string' }
end
