class ContactsInfo < ActiveRecord::Base
  attr_accessible :street, :city, :email, :phone_one, :phone_two, :lat, :lng, :coordinate

  attr_accessible :phone_three, :skype, :facebook, :vk, :google, :youtube, :twitter


  translates :street, :city
  attr_accessible :translations
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes

  class Translation
    attr_accessible :locale, :city_info_id
    attr_accessible  :street, :city

    rails_admin do
      visible false
      nested do
        field :locale , :hidden
        field :street do
          label 'Вулиця'
          help 'для прикладу: вул. Менцинського, 5'
        end
        field :city do
          label 'Місто'
          help 'для прикладу: м.Львів, Україна'
        end
      end
    end
  end
  # validates_presence_of :image, :message => "Виберіть фотографію, відповідно до зазначених розмірів! Поле не може бути пустим."

  def coordinate
    "hello"
  end
  rails_admin do
    navigation_label 'Контакти сторінка'
    label 'Контакт'
    label_plural 'Контакт'

    list do
      field :street
      field :city
      field :email
      field :phone_one
      field :lat
      field :lng
    end

    edit do
      field :translations, :globalize_tabs do
        label 'Локалізації'
      end
      field :email do
        label 'Електронна скринька'
        help ''
      end
      group :phones do
        label 'Номера телефонів'
        active false

        field :phone_one do
          label 'Номер телефону один'
          help ''
        end
        field :phone_two do
          label 'Номер телефону два'
          help ''
        end
        field :phone_three do
          label 'Номер телефону три'
          help ''
        end
      end
      group :social_networks do
        label 'Лінки на соціальні мережі та skype'
        active false

        field :skype do
          label 'skype:'
          help 'для прикладу: '
        end
        field :facebook do
          label 'facebook:'
          help 'для прикладу: '
        end
        # field :youtube do
        #   label 'youtube:'
        #   help 'для прикладу: '
        # end
        # field :twitter do
        #   label 'twitter:'
        #   help 'для прикладу: '
        # end
        # field :instagram do
        #   label 'instagram:'
        #   help 'для прикладу: '
        # end
        field :vk do
          label 'vkontakte:'
          help 'для прикладу: '
        end
        field :google do
          label 'google plus:'
          help 'для прикладу: '
        end
      end
      group :gmap do
        label 'Координати Google maps'
        active false
        field :lat do
          label 'Latitude'
          help ''
        end
        field :lng do
          label 'Longitude'
          help ''
        end
        field :coordinate do
          partial "get_coordinate_link"
          label 'Координати для Google map'
          help 'Перейдіть по цій ссилці щоб отримати Latitude, Longitude'
        end

      end
    end
  end
end
