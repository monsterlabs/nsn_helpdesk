class PeopleController < ApplicationController
  
  def change_photo
    @person = Person.find(params[:id])

    respond_to do |format|
      format.js { render 'change_photo.rjs'}
    end
  end

  def update_photo
    @person = Person.find(params[:id])

    respond_to do |format|
      format.js { render 'update_photo.rjs'}
    end
  end

end
