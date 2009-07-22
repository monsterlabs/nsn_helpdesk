class Link < ActiveRecord::Base
  has_many :tickets
  belongs_to :region
end
