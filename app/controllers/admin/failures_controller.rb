class Admin::FailuresController < ApplicationController
  filter_access_to :all
  super_scaffold :model => "Failure", :name_space => "admin", :columns => {:title => 'string'}
end