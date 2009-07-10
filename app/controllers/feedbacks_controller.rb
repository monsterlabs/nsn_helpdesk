class FeedbacksController < ApplicationController
  def create
    @story = Story.create(:name => params[:title], :requested_by => 'Alejandro Juárez Robles', :description => params[:message])
    if @story.errors.size == 0
      render 'sent'
    else
      render 'errors'
    end
  end

end
