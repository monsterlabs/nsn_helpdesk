class Person < ActiveRecord::Base
  validates_presence_of :firstname
  
  has_attached_file :photo, :styles => { :medium => "150x150>", :thumb => "50x50>" }
  belongs_to :user
  belongs_to :company
  belongs_to :region
  
  def self.fullname_by_user_id(id)
    Person.find_by_user_id(id).fullname
  end

  def fullname
    self.firstname + " " + self.lastname
  end

end
