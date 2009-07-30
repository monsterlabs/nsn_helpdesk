class Link < ActiveRecord::Base
  has_paper_trail

  has_many :tickets
  belongs_to :region
end
