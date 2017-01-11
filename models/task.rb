require './lib/point'

class Task
 include Mongoid::Document

 field :status, type: String
 field :pickup, type: Point
 field :delivery, type: Point
 field :number, type: Integer
end
