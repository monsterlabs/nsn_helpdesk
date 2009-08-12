class Admin::CompaniesController < ApplicationController
  super_scaffold :class_name => Company, :name_space => "admin", :columns => { :name=> 'string', :description => 'text', :url => 'string'}
end