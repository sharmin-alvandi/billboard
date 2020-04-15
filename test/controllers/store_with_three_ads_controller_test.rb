require 'test_helper'
require '/Users/sharminalvandi/src/github.com/sharmin-alvandi/billboard/test/controllers/advertisements_controller_test.rb'

class StoreWithThreeAdsControllerTest < AdvertisementsControllerTest 
  setup do
    @advertisement1 = advertisements(:one)
    @user = users(:valid_with_three_ads)
    sign_in(@user.username, '12345678')
    @store = stores(:with_three_ads)
  end

  # each store belongs to one user
  test "each store has up to three advertisements" do
    get new_advertisement_url, params: { 
      advertisement: { 
        collection_id: @advertisement1.collection_id, 
        description: @advertisement1.description, 
        image_url: @advertisement1.image_url, 
        product_url: @advertisement1.product_url, 
        store_id: @advertisement1.store_id, 
        title: @advertisement1.title, 
        effective_date: @advertisement1.effective_date,
        expiration_date: @advertisement1.expiration_date
      } 
    }
    assert_redirected_to advertisements_url
    assert_equal flash[:notice], 'The store has already reached the maximum number of ads.'
  end
end
