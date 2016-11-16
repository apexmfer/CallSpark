class CheckoutController < ApplicationController
    before_filter :require_login


    def new
      @new_checkout = Checkout.new
  end

  def index
  end
end
