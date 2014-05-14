class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 500
     
    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
      )
     
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
      )
    
    # change user status to paying user
    current_user.update_attribute(:paid, true)
    flash[:notice] = "You are now in the Wiki Private Club!"
    $user = User.find(current_user.id)
    redirect_to $user  

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end
end

