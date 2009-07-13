class Admin::ProductsController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Product, :name_space => "admin", :columns => {:name=> 'string', :description => 'text', :url => 'string', :company_id => 'select'}
end