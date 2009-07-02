class Admin::PrioritiesController < SuperScaffoldController
  def initialize
    @model = Priority
    @name_space = 'admin'
    super
  end
end
