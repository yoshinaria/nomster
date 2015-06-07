require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  test "create_comment" do
    user = FactoryGirl.create(:user)
    sign_in user
    place = FactoryGirl.create(:place, :user => user)
    post :create, :place_id => place.id, :comment => {
      :message => 'This place is awful',
      :rating  => '1_star',
    }
    assert_redirected_to place_path(place)
    comment = Comment.last
    assert_equal 'This place is awful', comment.message
    assert_equal '1_star', comment.rating

  end

end
