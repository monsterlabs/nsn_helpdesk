class SuperScaffoldController < ApplicationController
  def index
    @collection = @model.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
    render [@name_space, 'super_scaffold', 'index'].join('/')
  end

  def new
    @record = @model.new
    render [@name_space, 'super_scaffold', 'new'].join('/')
  end

  def create
    @record = @model.new(params[@model.params_name])
    if @record.save 
      redirect_to :controller => @model.controller_url(@name_space)
    else
      render [@name_space, 'super_scaffold', 'new'].join('/')
    end
  end

  def show
    @record = @model.find(params[:id])
    render [@name_space, 'super_scaffold', 'show'].join('/')
  end

  def edit
    @record = @model.find(params[:id])
    render [@name_space, 'super_scaffold', 'edit'].join('/')
  end

  def update
    @record = @model.find(params[:id])
    if @record.update_attributes(params[@model.params_name])
      redirect_to :controller => @model.controller_url(@name_space)
    else
      render [@name_space, 'super_scaffold', 'new'].join('/')
    end
  end

  def destroy
    @record = @model.find(params[:id])
    if @record.destroy
      redirect_to @model.controller_url(@name_space)
    end
    render [@name_space, 'super_scaffold', 'index'].join('/')
  end
end
