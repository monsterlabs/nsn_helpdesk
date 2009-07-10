class Admin::CompaniesController < ApplicationController
  filter_access_to :all
  super_scaffold :model => "Company", :name_space => "admin", :columns => { :name=> 'string', :description => 'text', :url => 'string'}
end