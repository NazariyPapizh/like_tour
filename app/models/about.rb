class About < ActiveRecord::Base
  attr_accessible :name, :description, :published, :date_start

  translates :description
  attr_accessible :translations
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  class Translation
    attr_accessible :locale, :about_id
    attr_accessible :description

    rails_admin do
      visible false
      nested do
        field :locale , :hidden
        field :description, :ck_editor do
          label 'Текст сторінки'
          help ''
        end
      end
    end
  end

  has_many :certificates, as: :imageable
  attr_accessible :certificates
  accepts_nested_attributes_for :certificates
  attr_accessible :certificates_attributes

  has_many :personnels, as: :personnel
  attr_accessible :personnels
  accepts_nested_attributes_for :personnels
  attr_accessible :personnels_attributes

  rails_admin do
    navigation_label 'Сторінки'
    label 'Про нас'
    label_plural 'Про нас'

    list do
      field :name
      field :certificates
      field :description
      field :published
    end

    edit do
      field :published do
        label 'Опубліковано:'
        help ''
      end
      field :name do
        label 'Назва'
        help ''
      end
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
      field :certificates do
        label 'Сертефікати'
      end
      field :personnels do
        label 'Фахівці'
      end
      # field :date_start do
      # end
    end
  end
end
