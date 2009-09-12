class Person < ActiveRecord::Base
  has_paper_trail

  validates_presence_of :firstname
  
  has_attached_file :photo, :styles => { :medium => "150x150>", :thumb => "50x50>" }
  belongs_to :user
  belongs_to :company
  belongs_to :region
  belongs_to :modified_by, :class_name => 'User'
  
  def fullname
    [firstname, lastname].join(' ')
  end

end
