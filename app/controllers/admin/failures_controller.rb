class Admin::FailuresController < ApplicationController
  filter_access_to :all
  super_scaffold :class_name => Failure, :name_space => "admin"
end