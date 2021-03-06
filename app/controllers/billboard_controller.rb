class BillboardController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @collections = Collection.all
    @advertisements = Advertisement.all
    if params[:collection_id] 
      # Find advertisements with the selected collection_id.
      @collection_id = params[:collection_id]
      @advertisements = Advertisement.where(collection_id: @collection_id)
      # The prompt for the the select collection list is "all collections" which its value is a string with zero length
      @advertisements = Advertisement.all if params[:collection_id] == ""
    end
  end
  # def search
  #   @collection_id = params[:collection_id]
  #   @advertisements = Advertisement.where("collection_id = ?", @collection_id)
  # end
end
