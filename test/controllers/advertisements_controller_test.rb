require 'test_helper'

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advertisement1 = advertisements(:one)
    sign_in
    
  end

  # each store belongs to one user
  test "each store has up to three advertisements" do
    @user = users(:valid)
    @store = stores(:one)
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

  # each user has only one store
  # each store has up to three advertisements

  test "should get index" do
    get advertisements_url
    assert_response :success
  end

  test "should get new" do
    Advertisement.destroy_all
    get new_advertisement_url
    assert_response :success
  end

  test "should create advertisement" do
    
    Advertisement.destroy_all
    assert_difference('Advertisement.count') do
      post advertisements_url, params: { 
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
    end

    assert_redirected_to advertisement_url(Advertisement.last)
  end

  test "should show advertisement" do
    get advertisement_url(@advertisement1)
    assert_response :success
  end

  test "should get edit" do
    get edit_advertisement_url(@advertisement1)
    assert_response :success
  end

  test "should update advertisement" do
    patch advertisement_url(@advertisement1), params: { 
      advertisement: { 
        collection_id: @advertisement1.collection_id, 
        description: @advertisement1.description, 
        image_url: @advertisement1.image_url, 
        product_url: @advertisement1.product_url, 
        store_id: @advertisement1.store_id, 
        title: @advertisement1.title
      } 
    }
    assert_redirected_to advertisement_url(@advertisement1)
  end

  test "should destroy advertisement" do
    assert_difference('Advertisement.count', -1) do
      delete advertisement_url(@advertisement1)
    end

    assert_redirected_to advertisements_url
  end

  def sign_in
    post login_url, params: { username: 'firstuser', password: 'password' }
  end
end
