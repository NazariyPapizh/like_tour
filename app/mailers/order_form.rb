class OrderForm < ActionMailer::Base
  default from: "Like Tour <support@voroninstudio.eu>"
  default to: 	"nazariy.papizh@gmail.com"


  def order_event_form_data(event, name, phone, email, message)
    @eventname = event
    @name = name
    @phone = phone
    @email = email
    @message = message
    to = []
    # to = 'nazariy.papizh@gmail.com'
    to = FeedBack.first.order_event.split(',')
    mail(:template_path => 'mailer_templates', :template_name => 'order_event', :subject => "Форма замовлення туру ...", to: to)
  end

  def feedback_form_data(name, phone, email, message)
    @name = name
    @phone = phone
    @email = email
    @message = message
    to = []
    # to = 'nazariy.papizh@gmail.com'
    to = FeedBack.first.feedback.split(',')
    mail(:template_path => 'mailer_templates', :template_name => 'feedback', :subject => "Форма зворотнього зв'язку ...", to: to)
  end
end
