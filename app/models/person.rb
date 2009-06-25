class People < ActiveRecord::Base
  validates_presence_of :firstname, :lastname1

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
