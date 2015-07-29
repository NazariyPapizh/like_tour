module CatalogHelper
  def other_category(category)
    categories = Category.where.not(id: category).where.not( id: '1').order(created_at: :asc)
  end

  def all_city_from_current_category(category)
    @current_category = Category.find_by_slug(category)

    @events = Tour.where(:category => @current_category.id, published: true).includes(:cities)

    cities_name = []
    @cities = []
    @events.each do |e|
      @cities += e.cities.select do |c|
        if  !cities_name.include?(c.name)
          cities_name.push(c.name)
          true
        else
          false
        end
      end
    end
    cities_name
  end
  def other_city(tour, city_name)
    @tour = Tour.find_by(tour)
    current_city = City.find_by_name(city_name)
  end
end
