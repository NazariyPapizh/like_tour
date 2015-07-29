class Personnel < ActiveRecord::Base
  attr_accessible :personnel_id, :personnel_type, :image, :first_name, :middle_name, :last_name, :work, :published, :position, :email, :phone_number

  belongs_to :personnel, polymorphic: true

  translates :first_name, :middle_name, :last_name, :work
  attr_accessible :translations
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  class Translation
    attr_accessible :locale, :personnel_id

    attr_accessible :first_name, :middle_name, :last_name, :work

    rails_admin do
      visible false
      nested do
        field :locale , :hidden

        field :first_name do
          label 'Прізвище'
          help ''
        end
        field :middle_name do
          label "Ім'я"
          help ''
        end
        field :last_name do
          label 'По батькові'
          help ''
        end
        field :work do
          label 'Посада'
          help ''
        end
      end
    end
  end

  has_attached_file :image,
                    styles: { large: "440x4400>"},
                    convert_options: { large: "-quality 94 -interlace Plane" },
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url'


  validates_presence_of :image, :message => "Виберіть фотографію, відповідно до зазначених розмірів! Поле не може бути пустим."

  rails_admin do
    label 'Фахівець'
    label_plural 'Фахівці'
    visible false
    list do
      field :first_name do
        label 'Прізвище'
      end
      field :middle_name do
        label "Ім'я"
      end
      field :last_name do
        label 'По батькові'
      end
      field :work do
        label 'Посада'
      end
      field :image do
        label 'Фотографія'
      end
    end
    edit do
      field :published do
        label 'Опубліковано:'
        help ''
      end
      field :image, :paperclip do
        label 'Фотографія'
        help 'Зображення для альбому повинне бути 440. / 440.'
      end
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
      field :email do
        label 'Електронна скринька'
        help ''
      end
      # field :phone_number do
      #   label 'Номер телефону'
      #   help ''
      # end
      field :position do
        label 'Позиція'
        help ''
      end
    end
  end
end
