class Link < ActiveRecord::Base
  has_many :tickets
  belongs_to :site_a, :class_name => 'Site'
  belongs_to :site_b, :class_name => 'Site'
end
