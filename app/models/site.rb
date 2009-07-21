class Site < ActiveRecord::Base
  has_many :ticket, :as => :linkable
end
