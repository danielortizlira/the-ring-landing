class HomeController < ApplicationController
  def index
    @subscription = NewsletterSubscription.new
  end
end
