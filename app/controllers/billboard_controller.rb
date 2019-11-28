class BillboardController < ApplicationController
  def index
    @collections = Collection.all
    @advertisements = Advertisement.all
    if params[:collection_id] 
      @collection_id = params[:collection_id]
      @advertisements = Advertisement.where("collection_id = ?", @collection_id)
      @advertisements = Advertisement.all if params[:collection_id] == ""
    end
    
  end

  def search
    @collection_id = params[:collection_id]
    @advertisements = Advertisement.where("collection_id = ?", @collection_id)
  end

  # def advertisement_params
  #   params.require(:advertisement).permit(:title, :store_id, :product_url, :description, :image_url, :collection_id)
  # end

end
