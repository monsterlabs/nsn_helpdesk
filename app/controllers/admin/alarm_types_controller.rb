class Admin::AlarmTypesController < ApplicationController
  filter_access_to :all
  super_scaffold :model => "AlarmType", :name_space => "admin", :columns => {:name=> 'string'}
end