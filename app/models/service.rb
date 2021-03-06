class Service < ActiveRecord::Base
  attr_accessible :name, :slug, :page, :published, :position, :comment

  translates :name, :slug, :page
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
    attr_accessible :locale, :service_id
    attr_accessible  :name, :slug, :page

    rails_admin do
      visible false
      nested do
        field :locale , :hidden
        field :name do
          label 'назва:'
          help 'Введіть унікальну назву !'
        end
        field :slug do
          label 'транслітерація назви:'
          help 'Використовується для url .'
        end
        field :page, :ck_editor do
          label 'контент сторінки:'
          help ''
        end
      end
    end
  end

  has_many :photo_galleries, as: :imageable
  attr_accessible :photo_galleries
  accepts_nested_attributes_for :photo_galleries
  attr_accessible :photo_galleries_attributes

  rails_admin do
    navigation_label 'Сторінки'
    label 'Послуга'
    label_plural 'Послуги'

    nestable_list true
    list do
      field :published
      field :position
      field :name
      field :slug
      field :page

    end

    edit do
      field :comment, :ck_editor do
        label 'Примітки:'
        help 'Це поле виключно для менеджерів! На сайті воно не відображається.'
      end
      field :published do
        label 'опубліковано:'
        help ''
      end
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
      field :photo_galleries do
        label 'Фотогалерея'
      end
    end
  end
end
