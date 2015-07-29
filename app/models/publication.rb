class Publication < ActiveRecord::Base
  include ActiveRecordResourceExpiration
  after_save :expire
  after_destroy :expire

  def expire
  	I18n.available_locales.each do |locale|
  		expire_page("#{locale}.html")
  	end
  end

  attr_accessible :name, :short_description, :description, :image, :banner_image, :banner, :published, :position

  translates :name, :slug, :short_description, :description
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
    attr_accessible :locale, :publication_id
    attr_accessible  :name, :slug, :short_description, :description

    rails_admin do
      visible false
      nested do
        field :locale , :hidden
        field :name do
          label 'Назва'
          help 'Введіть унікальну не повторювану назву'
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

  has_attached_file :image,
                    styles: { large: "300x190>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane" },
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url'


  validates_presence_of :image, :message => "Виберіть фотографію, відповідно до зазначених розмірів! Поле не може бути пустим."

  has_attached_file :banner_image,
                    styles: { large: "1000x600>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane" },
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url'

  rails_admin do
    navigation_label 'Публікації сторінка'
    label 'Публікація'
    label_plural 'Публікації'

    list do
      field :name
      field :slug
      field :short_description
      field :description
    end

    edit do
      field :published do
        label 'Опубліковано:'
        help ''
      end
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
      field :image, :paperclip do
        label 'Зображення'
        help 'Зображення повинне мати розмір 300px / 190px'
      end

      group :baner do
        label 'Обрані публікації'
        active false
        field :banner do
          label 'Баннер'
          help 'Поставте галочку якщо ця стаття повинна бути на банері.'
        end
        field :position do
          label 'Порядковий номер'
          help ''
        end
        field :banner_image, :paperclip do
          label 'Зображення для банера'
          help 'Зображення повинне мати розмір 1000px / 600px'
        end
      end

    end
  end
end
