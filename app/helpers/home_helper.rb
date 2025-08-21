module HomeHelper
  def app_store_download_badge_tag
    filename = case I18n.locale
    when :es then "download_on_the_app_store_badge_es.svg"
    else "download_on_the_app_store_badge_es.svg"
    end
    image_tag filename, alt: I18n.t("landing.hero.download_app_store"), class: "h-14 hover:scale-105 transition-transform"
  end

  def app_store_pre_order_badge_tag
    filename = case I18n.locale
    when :es then "pre_order_on_the_app_store_badge_es.svg"
    else "pre_order_on_the_app_store_badge_es.svg"
    end
    image_tag filename, alt: I18n.t("landing.hero.download_app_store"), class: "h-14 hover:scale-105 transition-transform"
  end

  def google_play_download_badge_tag
    filename = case I18n.locale
    when :es then "get_it_on_google_play_badge_es.png"
    else "get_it_on_google_play_badge_en.png"
    end
    image_tag filename, alt: I18n.t("landing.hero.get_it_on_play"), class: "h-14 hover:scale-105 transition-transform"
  end

  def google_play_pre_register_badge_tag
    filename = case I18n.locale
    when :es then "pre_register_on_google_play_badge_es.png"
    else "pre_register_on_google_play_badge_es.png"
    end
    image_tag filename, alt: I18n.t("landing.hero.get_it_on_play"), class: "h-14 hover:scale-105 transition-transform"
  end
end
