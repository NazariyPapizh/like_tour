class Category < ActiveRecord::Base
  attr_accessible :name, :description, :parent_id, :slug, :child_category_id
  attr_accessible  :published, :index_sort
  attr_accessible :image

  has_many :child_categories, class_name: "Category",
           foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category"
  # has_many :tours

  translates :name, :slug, :description
  attr_accessible :translations
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  # has_and_belongs_to_many :join_tour_tables
  has_and_belongs_to_many :tours, join_table: :join_tour_tables

  # generate slug for locale if other locale empty set value slug current name and slug with index locale name
  validates :name, :uniqueness => true, presence: true
  after_validation :generate_slug
  def generate_slug
    if self.errors[:name].empty?
      self.translations_by_locale.keys.each do |locale|
        t = self.translations_by_locale[locale.to_sym]
        if !t.slug || t.slug == ''
          #current_locale = I18n.locale
          req_locale = locale.to_sym
          req_locale = :ru if req_locale.to_sym == :uk

          I18n.with_locale req_locale do
            if t.name && t.name != ''
              t.slug = t.name.parameterize
            else
              t.slug = "#{ I18n.with_locale(:ru) {|locale|self.name.parameterize } }-#{locale}"
            end
          end
        end
      end
    end
  end

  class Translation
    attr_accessible :locale, :category_id

    attr_accessible  :name, :slug, :description


    rails_admin do
      visible false
      nested do
        field :locale , :hidden
        field :name do
          label 'Назва'
          help 'Введіть унікальну не повторювану назву'
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

  has_attached_file :image,
                    styles: { large: "1920x337>" },
                    convert_options: { large: "-quality 94 -interlace Plane" },
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url'



  rails_admin do
    navigation_label 'Каталог'
    label 'Категорія'
    label_plural 'Категорії'

    list do
      field :name
      field :parent
      field :image
      field :slug
      # field :description
      # field :published
    end

    edit do
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
      field :image, :paperclip do
        label 'Зображення для банера'
        help 'Зображення повинне мати розмір 1920x337px'
      end
      field :parent do
        label 'Категорія'
        help ''
      end
      field :published do
        label 'Публікувати'
        help 'Для табів на головну'
      end
      field :index_sort do
        label 'Порядок сортування'
        help 'Для табів на головну'
      end
    end

  end
end
