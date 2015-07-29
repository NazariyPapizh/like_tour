class CityJoin < ActiveRecord::Base

  belongs_to :tour
  belongs_to :city

end
