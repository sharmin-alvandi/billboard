class AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
  #before_action :count_ads, only: [:create]
 

  # GET /advertisements
  # GET /advertisements.json
  def index
    
    
      @advertisements = Advertisement.all
    
      
    
    # @advertisements = Advertisement.all unless defined? @store_id
  end

  # GET /advertisements/1
  # GET /advertisements/1.json
  def show
  end

  # GET /advertisements/new
  def new
    @advertisement = Advertisement.new
  end

  # GET /advertisements/1/edit
  def edit
  end

  # POST /advertisements
  # POST /advertisements.json
  def create
    
    store_id = advertisement_params[:store_id]

    # @advertisements = Advertisement.where("store_id = ?", store_id)
    # count = @advertisements.count
    # @count = search_store(store_id)
    # count = @advertisements.count
    
      respond_to do |format|
        # Each store are not allowed to add more than 3 active(not expired) ads.
        if Advertisement.max_ads_reached?(store_id: store_id)
          # @store_id = advertisement_params[:store_id]
          # @advertisements2 = Advertisement.where("store_id = ?", @store_id)
          format.html { redirect_to search_store_advertisements_url(store_id: store_id), notice: 'The store has already reached the maximum number of ads.' }
          # format.html { redirect_to billboard_index_url, notice: 'The store has already reached the maximum number of ads'}
          format.json { head :no_content }
          # return
        else
          @advertisement = Advertisement.new(advertisement_params)

          if !@advertisement.valid?
            format.html { render 'new'}
            # format.html { redirect_to @advertisement, notice: @advertisement.errors.messages }
          else
            if @advertisement.save
              format.html { redirect_to @advertisement, notice: 'Advertisement was successfully created.'}
              format.json { render :show, status: :created, location: @advertisement }
            else
              format.html { render :new }
              format.json { render json: @advertisement.errors, status: :unprocessable_entity }
            end
          end
        end
      end
    end

  # PATCH/PUT /advertisements/1
  # PATCH/PUT /advertisements/1.json
  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully updated.' }
        format.json { render :show, status: :ok, location: @advertisement }
      else
        format.html { render :edit }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisements/1
  # DELETE /advertisements/1.json
  def destroy
    @advertisement.destroy
    respond_to do |format|
      format.html { redirect_to advertisements_url, notice: 'Advertisement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_store
    # puts "********************************storeidbefore  #{store_id}"
    #  @store_id = advertisement_params[:store_id]

    @advertisements = Advertisement.where("store_id = ?", params[:store_id])
    # puts "*********************#{$store_id}"
    
    # @count = @advertisements.count
    
    # redirect_to store_ads_url, notice: 'More than three ads are not allowed.'+count.to_s 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertisement_params
      params.require(:advertisement).permit(:title, :store_id, :product_url, :description, :image_url, :collection_id, :effective_date, :expiration_date, :active)
    end
end
