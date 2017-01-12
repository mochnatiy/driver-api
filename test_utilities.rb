require 'test/unit'
require File.expand_path('./lib/distance.rb', File.dirname(__FILE__))

class DistanceTest < Test::Unit::TestCase
  def test_pythagor_distance
    distance = Distance.pythagor_distance(3, 5, 3, 4)
    assert_equal(distance, 1)
  end
  
  def test_haversine_distance
    # As test we take great circle distance between Bergen and Amsterdam with inaccuracy
    distance = Distance.haversine_distance(52.38, 4.9, 60.4, 5.32)
    assert_includes(885..895, distance)
  end
end