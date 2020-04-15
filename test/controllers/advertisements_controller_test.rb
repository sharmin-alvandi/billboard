require 'test_helper'

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advertisement1 = advertisements(:one)
    
    
  end

  # each store belongs to one user
  

  # each user has only one store
  # each store has up to three advertisements

  test "should get index" do
    @user = users(:valid)
    sign_in(@user.username, 'password')
    get advertisements_url
    assert_response :success
  end

  test "should get new" do
    @user = users(:valid)
    sign_in(@user.username, 'password')
    get new_advertisement_url
    assert_response :success
  end

  test "should create advertisement" do
    @user = users(:valid)
    sign_in(@user.username, 'password')
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

  test "cannot create an advertisement when max is reached" do
    @user = users(:valid)
    sign_in(@user.username, 'password')
    # store = Store.find_by('user_id = ?', @user.id)
    # Advertisement.stubs(:where).with(store_id: store.id).returns(['', '', ''])
    # Advertisement.expects(:where).with(store_id: store.id).returns(['', '', ''])
    expectation = Advertisement.expects(:max_ads_reached?).returns(true)
    # binding.pry
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

  test "should show advertisement" do
    @user = users(:valid)
    sign_in(@user.username, 'password')
    get advertisement_url(@advertisement1)
    assert_response :success
  end

  test "should get edit" do
    @user = users(:valid)
    sign_in(@user.username, 'password')
    get edit_advertisement_url(@advertisement1)
    assert_response :success
  end

  test "should update advertisement" do
    @user = users(:valid)
    sign_in(@user.username, 'password')
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
    @user = users(:valid)
    sign_in(@user.username, 'password')
    assert_difference('Advertisement.count', -1) do
      delete advertisement_url(@advertisement1)
    end

    assert_redirected_to advertisements_url
  end

  def sign_in(username, password)
    post login_url, params: { username: username, password: password }
  end





    # private
    #  def create_ad (number, params = {})
    #   ad_params = {
    #     id: number,
    #     title: "Title #{number}",
    #     store_id: 1,
    #     product_url: "URL #{number}",
    #     description: "Description #{number}",
    #     image_url: "coat.jpg",
    #     collection_id: 1,
    #     effective_date: '2020-04-25',
    #     expiration_date: '2020-04-26',
    #   }

    #   Advertisement.new(ad_params.merge(params)).save
    #  end
end

# class StoreWithThreeAdsControllerTest < AdvertisementsControllerTest
#   setup do
#     @advertisement1 = advertisements(:one)
#     @user = users(:valid_with_three_ads)
#     sign_in(@user.username, '12345678')
#     @store = stores(:with_three_ads)
#   end

#   # each store belongs to one user
  # test "each store has up to three advertisements" do
  #   get new_advertisement_url, params: { 
  #     advertisement: { 
  #       collection_id: @advertisement1.collection_id, 
  #       description: @advertisement1.description, 
  #       image_url: @advertisement1.image_url, 
  #       product_url: @advertisement1.product_url, 
  #       store_id: @advertisement1.store_id, 
  #       title: @advertisement1.title, 
  #       effective_date: @advertisement1.effective_date,
  #       expiration_date: @advertisement1.expiration_date
  #     } 
  #   }
  #   assert_redirected_to advertisements_url
  #   assert_equal flash[:notice], 'The store has already reached the maximum number of ads.'
  # end
# end
