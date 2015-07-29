class Certificate < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type, :image, :title, :alt

  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
                    styles: { thumb: "297x421!", large: "595x842>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane" },
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url',
                    default_url:"asset_path('default_image.png')"


  validates_presence_of :image, :message => "Виберіть фотографію, відповідно до зазначених розмірів! Поле не може бути пустим."

  rails_admin do
    label 'Сертефікат'
    label_plural 'Сертефікати'
    visible false

    edit do
      field :title do
        label 'Назва'
        help ''
      end
      field :image, :paperclip do
        label 'Зображення'
        help 'Зображення для альбому повинне бути ширина - 595. / висота - 842.'
      end
    end
  end
end
