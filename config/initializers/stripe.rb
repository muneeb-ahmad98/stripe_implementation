Stripe.api_key = Rails.application.credentials.stripe_secret_key
StripeEvent.signing_secret = Rails.application.credentials.stripe[:signing_secret]
StripeEvent.configure do |events|
end
