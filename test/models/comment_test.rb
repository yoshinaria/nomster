require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "humanize_rating" do
    comment = Comment.new(:rating => '1_star')
    assert_equal "one star", comment.humanized_rating
  end

  test "number_of_stars" do
    comment = Comment.new(:rating => '3_stars')
    assert_equal "***", comment.number_of_stars
  end
end
