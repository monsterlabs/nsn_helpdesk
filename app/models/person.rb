class Person < ActiveRecord::Base
  has_paper_trail

  validates_presence_of :firstname
  
  has_attached_file :photo, :styles => { :medium => "150x150>", :thumb => "50x50>" }
  belongs_to :user
  belongs_to :company
  belongs_to :region

  def fullname
    [self.firstname, self.lastname].join(' ')
  end

end
