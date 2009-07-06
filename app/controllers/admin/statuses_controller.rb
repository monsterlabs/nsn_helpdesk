class Admin::StatusesController < SuperScaffoldController
  def initialize
    @model = Status
    @name_space = 'admin'
    super
  end
end