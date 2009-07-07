class Admin::StatusesController < SuperScaffoldController
  filter_access_to :all
  def initialize
    @model = Status
    @name_space = 'admin'
    super
  end
end