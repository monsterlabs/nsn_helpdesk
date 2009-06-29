class Person < ActiveRecord::Base
  validates_presence_of :firstname, :lastname1

  has_attached_file :photo, :styles => { :medium => "150x150>", :thumb => "50x50>" }

  belongs_to :user

  def fullname
    self.firstname + " " + self.lastname1
  end

end
