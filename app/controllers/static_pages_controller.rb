class StaticPagesController < ApplicationController
  layout "static_page"

  def privacy_policy; end

  def terms_and_conditions; end
end
