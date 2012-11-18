class LiteracyRate
  include Mongoid::Document
  field :country_or_area, type: String
  field :year, type: String
  field :value, type: String
end
