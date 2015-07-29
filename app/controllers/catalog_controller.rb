class CatalogController < ApplicationController
  before_filter :filters, only: [:category, :category_with_city]
  skip_before_filter :set_locale, only: [:get_cities, :get_filters_from_category, :get_filter_words]

  def category
    @category = Category.find_by_slug(params[:category_name])
    @categories = Category.joins(:tours).order(name: :asc).uniq
    # category_list = Category.order(name: :asc)
  end

  def category_with_city
    @category = Category.find_by_slug(params[:category_name])
    # @categories = Category.order(created_at: :asc)
    @categories = Category.joins(:tours).order(name: :asc).uniq
    @city = City.find_by_slug(params[:city_name])
    # @cities = City.where('id in (?)', CityJoin.joins(:tour).joins(:city).where(tours: { category_id: @category.id }).pluck(:city_id).uniq)
    @cities = City.joins(tours: :categories).where(tours: {published: true}).where(categories: {id: @category.id}).where.not(id: @city.id ).uniq
    params_flags = (params[:flags] || '').split(',')
    # @tags = FilterWord.joins(filter_joins: [{tour: [{city_joins: :city}, :category]}]).where(categories: {id: @category.id}).where(cities: {id: @city.id}).uniq  # приклад для наслідування зі складним запитом))
    @tags_s = FilterWord.joins(tours: [:categories, :cities]).where(tours: {published: true}).where(categories: {id: @category.id}, cities: {id: @city.id}).uniq
    # @tours = Tour.joins(city_joins: [{tour: :category}, :city]).where(categories: {id: @category.id}).where(cities: {id: @city.id})
    @tours = Tour.joins(:categories, :cities).where(tours: {published: true}).where(categories: {id: @category.id}, cities: {id: @city.id})


    # @tours = @tours.select{|e| e.translations_by_locale.keys.include?(I18n.locale) }

    @checked_flags = params_flags
  end

  def tour
    category = Category.find_by_slug(params[:category_name])
    city = City.find_by_slug(params[:city_name])
    @event = Tour.find_by_slug(params[:tour_name])
    # @cities = City.where('id in (?)', CityJoin.joins(:tour).joins(:city).where(tours: { category_id: category.id }).pluck(:city_id).uniq).where.not(id: @event.cities[0])
    # @cities = City.joins(city_joins: [{tour: :categories}]).where(categories: {id: @category.id}).where.not(id: @event.cities[0])  # приклад для наслідування зі складним запитом))
    @cities = City.joins(tours: :categories).where(categories: {id: category.id}).where.not(id: city.id ).uniq
    @events = Tour.joins(:categories).published.where(categories: {id: category.id}).where.not(id: @event.id ).limit(3)

  end

#   ajax requests
  def get_cities
    category = Category.find_by_slug(params[:category])
    # cities = City.where('id in (?)', CityJoin.joins(:tour).joins(:city).where(tours: { category_id: category.id }).pluck(:city_id).uniq)
    cities = City.joins(tours: :categories).where(tours: {published: true}).where(categories: {id: category.id}).uniq
    city_name = []
    cities.each do |c|
      city_name.push( {name: c.name, slug: c.slug} )
    end
    render(inline: city_name.to_json)
  end

  def get_filters_from_category
    category = Category.find_by_slug(params[:category])
    city = City.joins(tours: :categories).where(categories: {id: category.id}).first
    # words = FilterWord.where('id in (?)', FilterJoin.joins(:tour).joins(:filter_word).where(tours: { category_id: category.id }).pluck(:filter_word_id).uniq)

    # words = FilterWord.joins(tours: :categories)
    # words = words.where(categories: {id: category.id}).uniq if category.try(&:id)
    words = FilterWord.joins(tours: [:categories, :cities]).where(tours: {published: true}).where(categories: {id: category.id}, cities: {id: city.id}).uniq
    # words = FilterWord.joins(tours: [:categories, :cities]).where(categories: {id: category.id}, cities: {id: city.id}).uniq
    words_name = []
    words.each do |c|
      words_name.push( {name: c.name, slug: c.slug} )
    end
    # s = words_name.join(',')
    # render(inline: s)
    render(inline: words_name.to_json)
  end


  def get_filter_words
    category = Category.find_by_slug(params[:category])
    city = City.find_by_slug(params[:city])
    # words = FilterWord.where('id in (?)', FilterJoin.joins(:tour).joins(:filter_word).where(tours: { category_id: category.id }).pluck(:filter_word_id).uniq)
    # words = FilterWord.joins(tours: :categories).where(categories: {id: category.id}).uniq
    # words = FilterWord.joins(tours: [:categories, :cities]).where(categories: {id: category.id}, cities: {id: city.id}).uniq
    words = FilterWord.joins(tours: [:categories, :cities]).where(tours: {published: true}).where(categories: {id: category.id}, cities: {id: city.id}).uniq
    words_name = []
    words.each do |c|
      # words_name.push(c.name)
      words_name.push( {name: c.name, slug: c.slug} )
    end
    # s = words_name.join(',')
    # render(inline: s)
    render(inline: words_name.to_json)
  end

  def order_event
    event = params[:eventname]
    name = params[:name]
    phone = params[:phone]
    email = params[:email]
    message = params[:message]
    OrderForm.order_event_form_data(event, name, phone, email, message).deliver
  end

  def feedback
    name = params[:name]
    phone = params[:phone]
    email = params[:email]
    message = params[:message]
    OrderForm.feedback_form_data(name, phone, email, message).deliver
  end
end
