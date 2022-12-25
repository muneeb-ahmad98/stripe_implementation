Stripe.api_key = Rails.application.credentials.stripe_secret_key
StripeEvent.signing_secret = Rails.application.credentials.stripe[:signing_secret]
StripeEvent.configure do |events|
  events.subscribe 'payment_intent.succeeded' do |event|
    pp 'payment Succeeded'
  end

  events.subscribe 'payment_intent.payment_failed' do |event|
    pp 'Payment failed'
  end

  events.subscribe 'payment_intent.requires_action' do |event|
    pp 'Payment requires_action'
  end
  events.subscribe 'checkout.session.completed' do |event|
    pp 'checkout completed'
    customer_details = event.data.object.customer_details
    OrderMailer.order_placed(customer_details).deliver_now
  end
end
