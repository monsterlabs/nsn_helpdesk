class Admin::PrioritiesController < ApplicationController
  super_scaffold :class_name => Priority, :name_space => "admin", :columns => { :name => 'string', :time_limit => 'string' }
end
