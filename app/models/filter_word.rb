class FilterWord < ActiveRecord::Base
  attr_accessible :name, :description, :slug

  has_many :filter_joins
  has_many :tours, through: :filter_joins
  # has_and_belongs_to_many :tours, join_table: 'filter_joins'

  translates :name, :slug, :description
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
    attr_accessible :locale, :filter_word_id
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

  rails_admin do
    parent Tour
    label 'Фільтр'
    label_plural 'Фільтри'

    list do
      field :name
      field :slug
      field :description
    end

    edit do
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
    end
  end
end
