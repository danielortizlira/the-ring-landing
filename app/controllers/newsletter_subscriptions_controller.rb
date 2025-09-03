class NewsletterSubscriptionsController < ApplicationController
  def create
    @subscription = NewsletterSubscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.turbo_stream
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "newsletter_form",
            partial: "newsletter_subscriptions/form",
            locals: { subscription: @subscription }
          )
        end
      end
    end
  end


  private

  def subscription_params
    params.require(:newsletter_subscription).permit(:email)
  end
end
