class BillboardController < ApplicationController
  def index
    @collections = Collection.all
    @advertisements = Advertisement.all
  end
end
