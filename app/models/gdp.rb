class Gdp
  include Mongoid::Document
  field :country, type: String
  field :year, type: String
  field :value, type: String
end
