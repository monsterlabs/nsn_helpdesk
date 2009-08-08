class Admin::LinksController < LinksController
  unloadable

  def destroy
    @link = Link.find(params[:id])
    if @link.destroy
      redirect_to links_url
    end
  end
end
