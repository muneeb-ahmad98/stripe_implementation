class OrderMailer < ApplicationMailer
  def order_placed(customer)
    @customer = customer
    mail to: @customer.email, subject: "Order placed"
  end
end
