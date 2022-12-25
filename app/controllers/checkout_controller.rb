class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items:  [{
        name: product.name,
        amount: product.price,
        currency: "usd",
        quantity: 1
      }],
      metadata: {'order_id'=> product.id},
      mode: 'payment',
      success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'http://localhost:3000/cancel',
    })
    respond_to do |format|
      format.js
    end
  end

  def cancel
  end

  def success
    if params[:session_id].present?
      @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items","customer"]})
      @session_with_expand.line_items.data.each do |line_item|
        product = Product.find_by(name: line_item.description)
      end
    else
      redirect_to cancel_url, alert: "No info to display"
    end
  end
end
