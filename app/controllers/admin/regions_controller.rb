class Admin::RegionsController < SuperScaffoldController
  def initialize
    @model = Region
    @name_space = 'admin'
    super
  end
end
