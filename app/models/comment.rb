class Comment < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :ticket
  belongs_to :user
  default_scope :order => 'created_at ASC'
end
