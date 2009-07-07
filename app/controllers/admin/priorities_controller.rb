class Admin::PrioritiesController < SuperScaffoldController
  filter_access_to :all
  def initialize
    @model = Priority
    @name_space = 'admin'
    super
  end
end
