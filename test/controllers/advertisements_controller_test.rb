require 'test_helper'

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advertisement1 = advertisements(:one)
    @advertisement2 = advertisements(:two)
    @advertisement3 = advertisements(:three)
    @advertisement4 = advertisements(:four)
  end

  # each store belongs to one user
  test "each store has up to three advertisements" do
    @advertisement1.save
    @advertisement2.save
    @advertisement3.save
    post advertisements_url, params: { 
      advertisement: { 
        collection_id: @advertisement4.collection_id, 
        description: @advertisement4.description, 
        image_url: @advertisement4.image_url, 
        product_url: @advertisement4.product_url, 
        store_id: @advertisement4.store_id, 
        title: @advertisement4.title 
      } 
    }
    assert_redirected_to advertisements_url
    assert_equal flash[:notice], 'The store has already reached the maximum number of ads.'
  end

  # each user has only one store
  # each store has up to three advertisements

  test "should get index" do
    get advertisements_url
    assert_response :success
  end

  test "should get new" do
    get new_advertisement_url
    assert_response :success
  end

  test "should create advertisement" do
    assert_difference('Advertisement.count') do
      post advertisements_url, params: { advertisement: { collection_id: @advertisement.collection_id, description: @advertisement.description, image_url: @advertisement.image_url, product_url: @advertisement.product_url, store_id: @advertisement.store_id, title: @advertisement.title } }
    end

    assert_redirected_to advertisement_url(Advertisement.last)
  end

  test "should show advertisement" do
    get advertisement_url(@advertisement)
    assert_response :success
  end

  test "should get edit" do
    get edit_advertisement_url(@advertisement)
    assert_response :success
  end

  test "should update advertisement" do
    patch advertisement_url(@advertisement), params: { advertisement: { collection_id: @advertisement.collection_id, description: @advertisement.description, image_url: @advertisement.image_url, product_url: @advertisement.product_url, store_id: @advertisement.store_id, title: @advertisement.title } }
    assert_redirected_to advertisement_url(@advertisement)
  end

  test "should destroy advertisement" do
    assert_difference('Advertisement.count', -1) do
      delete advertisement_url(@advertisement)
    end

    assert_redirected_to advertisements_url
  end
end
