require 'mongoid'
require './lib/point'
require './lib/distance'

class Task
  include Mongoid::Document

  field :status, type: String
  field :pickup, type: Point
  field :delivery, type: Point
  field :number, type: Integer
 
  def plane_distance(location)
    Distance.pythagor_distance(
      location.x.to_i,
      location.y.to_i,
      pickup.x.to_i,
      pickup.y.to_i
    )
  end
  
  def great_circle_distance(location)
    Distance.haversine_distance(
      location.x.to_i,
      location.y.to_i,
      pickup.x.to_i,
      pickup.y.to_i
    )
  end
end
