class AlarmType < ActiveRecord::Base
  has_many :priorities
end
