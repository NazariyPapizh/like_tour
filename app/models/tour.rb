class Tour < ActiveRecord::Base
  include ActiveRecordResourceExpiration
  after_save :expire
  after_destroy :expire

  def expire
  	I18n.available_locales.each do |locale|
  		expire_page("#{locale}.html")
  	end
  end


  attr_accessible :name, :short_description, :description, :city, :slug, :categories, :category_id, :price, :date_begin, :date_end, :published, :string_price
  attr_accessible :comment
  attr_accessible :public_uk, :public_en, :public_pl, :public_ru

  has_many :city_joins
  has_many :cities, through: :city_joins
  attr_accessible :city, :city_ids

  has_many :filter_joins
  has_many :filter_words, through: :filter_joins
  # has_and_belongs_to_many :filter_words, join_table: 'filter_joins'
  attr_accessible :filter_words, :filter_word_ids

  # has_and_belongs_to_many :join_tour_tables
  has_and_belongs_to_many :categories, join_table: :join_tour_tables
  attr_accessible :categories, :category_ids

  translates :name, :slug, :short_description, :description, :city, :string_price
  attr_accessible :translations
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  # generate slug for locale if other locale empty set value slug current name and slug with index locale name
  validates :name, :uniqueness => true, presence: true
  after_validation :generate_slug
  def generate_slug
    if self.errors[:name].empty?
      self.translations_by_locale.keys.each do |locale|
        t = self.translations_by_locale[locale.to_sym]
        if t.slug.blank?
          #current_locale = I18n.locale
          req_locale = locale.to_sym
          req_locale = :ru if req_locale.to_sym == :uk

          I18n.with_locale req_locale do
            if t.name.present?
              t.slug = t.name.parameterize
            else
              t.slug = "#{ I18n.with_locale(:ru) {|locale|self.name.parameterize } }-#{locale}"
            end
          end
        end
      end
    end
  end



  scope :published, ->{where(published: :t).where("public_#{I18n.locale} = 't'")}

  def with_translations(*locales)
    locales = translated_locales if locales.empty?
    includes(:translations).with_locales(locales).with_required_attributes
  end

  class Translation
    attr_accessible :locale, :tour_id
    attr_accessible  :name, :slug, :short_description, :description, :city, :string_price

    rails_admin do
      visible false
      nested do
        field :locale , :hidden
        field :name do
          label 'Назва'
          help 'Введіть унікальну не повторювану назву'
        end
        field :string_price do
          label 'Ціна'
          help ''
        end
        field :short_description do
          label 'Короткий опис'
          help ''
        end
        field :description, :ck_editor do
          label 'Опис'
          help ''
        end

        field :slug do
          label 'Транслітерація назви'
          help ''
        end
      end
    end
  end

  has_many :photo_galleries, as: :imageable
  attr_accessible :photo_galleries
  accepts_nested_attributes_for :photo_galleries, :allow_destroy => true
  attr_accessible :photo_galleries_attributes

  def self.get_item_class
    PhotoGallery
  end
  def self.get_item_field_name
    :photo_galleries
  end

  validates_presence_of :cities, :message => "Виберіть місто! Поле не може бути пустим."
  rails_admin do
    parent Category
    label 'Подія'
    label_plural 'Події'

    list do
      field :published
      field :name
      field :categories
      field :cities
      field :filter_words
    end

    edit do
      group :public do
        label "На яких мовах публікувати ?"
        # active false
      end
      field :public_uk do
        label 'Українською'
        group :public
      end
      field :public_en do
        label 'Англійською'
        group :public
      end
      field :public_pl do
        label 'Польською'
        group :public
      end
      field :public_ru do
        label 'російською'
        group :public
      end


      field :comment, :ck_editor do
        label 'Примітки:'
        help 'Це поле виключно для менеджерів! На сайті воно не відображається.'
      end
      field :published do
        label 'Опубліковано:'
        help ''
      end
      field :published do
        label 'Опубліковано:'
        help ''
      end
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
      field :cities do
        label 'Місто'
      end
      field :filter_words do
        label 'Слово фільтр'
      end
      field :photo_galleries do
        label 'Фотогалерея'
      end

      field :categories do
        label 'Категорія'
        help ''
      end
      field :date_begin do
        label 'Дата початку'
        help ''
      end
      field :date_end do
        label 'Дата завершення'
        help ''
      end
    end
  end
end
