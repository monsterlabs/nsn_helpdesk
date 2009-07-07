class Admin::RegionsController < SuperScaffoldController
  filter_access_to :all
  def initialize
    @model = Region
    @name_space = 'admin'
    super
  end
end
