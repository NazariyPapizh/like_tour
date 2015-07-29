class FilterJoin < ActiveRecord::Base

  belongs_to :tour
  belongs_to :filter_word

end
