class FeedBack < ActiveRecord::Base
  attr_accessible :order_event, :feedback

  rails_admin do
    navigation_label 'Контакти сторінка'
    label 'Електронна скринька'
    label_plural 'Електронні скриньки'
    list do
      field :order_event do
        label 'Замовлення:'
      end
      field :feedback do
        label "Зворотній зв'язок:"
      end
    end
    edit do
      field :order_event do
        label 'Замовлення туру    :'
        help 'можна вводити через кому декілька електронних адресів...'
      end
      field :feedback do
        label "Зворотній зв'язок:"
        help 'можна вводити через кому декілька електронних адресів...'
      end
    end
  end
end
