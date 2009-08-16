class Mail < ActiveRecord::Base
  belongs_to :mailable, :polymorphic => true
end
