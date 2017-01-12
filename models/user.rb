require 'mongoid'

class User
  include Mongoid::Document

  field :token, type: String
  field :access_level, type: String
end
