module ApplicationHelper
  def embedded_svg filename, options={}
    embedded_svg_from_abs(Rails.root.join('app', 'assets', 'images', 'svg', filename), options)
  end

  def embedded_svg_from_abs filename, options = {}
    file = File.read(filename)
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def embedded_svg_from_root_directory filename, options = {}
    embedded_svg_from_abs(Rails.root.join( filename), options)
  end

  def self.embedded_svg_js filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', 'svg', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def get_category
    @category ||= Category.order(created_at: :asc )
  end

  def get_cities_from_current_category(category)
    category = Category.find(category)
    # cities = City.where('id in (?)', CityJoin.joins(:tour).joins(:city).where(tours: { category_id: category.id }).pluck(:city_id).uniq)
    cities = City.joins(tours: :categories).where(categories: {id: category.id}).uniq
  end

  def get_filters_from_current_category(category)
    category = Category.find(category)
    # words = FilterWord.where('id in (?)', FilterJoin.joins(:tour).joins(:filter_word).where(tours: { category_id: category.id }).pluck(:filter_word_id).uniq)
    words = FilterWord.joins(tours: :categories).where(categories: {id: category.id}).uniq
  end

  def get_tags(cat_name)
    @category = Category.find_by_name(cat_name)
    @tags = FilterWord.joins(tours: :categories).where(categories: {id: @category.id}).uniq
    # @events = Tour.where(category_id: @category.id, published: true)
    @events = Tour.joins(:categories).where(categories: {id: @category.id}, published: true)
  end

  def get_tags_for_events(cat_name)
    @category = Category.find_by_name(cat_name)
    if @category
      @events = Tour.joins(:join_tour_tables).where(join_tour_tables: {category_id: @category.id}, published: true).includes(:filter_words).where(published: true)

      names = []
      @filter_words = []
      @events.each do |e|
        @filter_words += e.filter_words.select do|f|
          if  !names.include?(f.name)
            names.push(f.name)
            true
          else
            false
          end
        end
      end
    end
  end

  def words_limit(limit)
    string_arr = self.split(' ')
    string_arr.count > limit ? "#{string_arr[0..(limit-1)].join(' ')}..." : self
  end
  def partners
    brands = BrandCarousel.where(published: true).order(position: :asc)
  end
  def contacts
    contact = ContactsInfo.first
  end
  def service
    return Service.where(published: true).order(position: :asc)
  end

  def google_map
    ContactsInfo.first
  end
end
