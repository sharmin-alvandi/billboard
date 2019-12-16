class AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
 
  # GET /advertisements
  # GET /advertisements.json
  def index
      @store = Store.find_by('user_id = ?', current_user.id)
      @advertisements = Advertisement.where('store_id = ?', @store.id)  
  end

  # GET /advertisements/1
  # GET /advertisements/1.json
  def show
  end

  # GET /advertisements/new
  def new
    @advertisement = Advertisement.new
    @store = Store.find_by('user_id = ?', current_user.id)
    store_id = @store.id
    # Each store are not allowed to add more than 3 active(not expired) ads.
    if Advertisement.max_ads_reached?(store_id: store_id)
      redirect_to advertisements_url, notice: 'The store has already reached the maximum number of ads.'
    end
  end

  # GET /advertisements/1/edit
  def edit
    @store = Store.find_by('user_id = ?', current_user.id)
  end

  # POST /advertisements
  # POST /advertisements.json
  def create
    store_id = advertisement_params[:store_id]
    respond_to do |format|
      @advertisement = Advertisement.new(advertisement_params)
      if !@advertisement.valid?
        format.html { render 'new'}
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
