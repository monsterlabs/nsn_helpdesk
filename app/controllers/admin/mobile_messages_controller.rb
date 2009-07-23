class Admin::MobileMessagesController < ApplicationController
  def index
    @collection = MobileMessage.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
  end
end
