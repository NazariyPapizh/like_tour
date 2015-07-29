class City < ActiveRecord::Base
  attr_accessible :name, :slug

  has_many :city_joins
  has_many :tours, through: :city_joins

  translates :name, :slug
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
    attr_accessible :locale, :city_id
    attr_accessible  :name, :slug

    rails_admin do
      visible false
      nested do
        field :locale , :hidden
        field :name do
          label 'Назва'
          help 'Введіть унікальну не повторювану назву'
        end
        field :slug do
          label 'Транслітерація назви'
          help ''
        end
      end
    end
  end

  rails_admin do
    parent Tour
    label 'Місто'
    label_plural 'Міста'

    list do
      field :name
      field :slug
    end

    edit do
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
    end

  end
end
