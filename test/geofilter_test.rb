require "test_helper"

class GeofilterTest < Minitest::Test

  def test_ing

    ENV['really?'] = "yes"

    assert_equal "yes", ENV["really?"]
  end

end