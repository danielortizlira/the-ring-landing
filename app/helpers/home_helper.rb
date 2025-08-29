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

  def features
    [ "technique", "endurance", "power", "burn", "anywhere", "strength" ]
  end

  def feature_icon(key:, color:)
      svg_class = "h-6 w-6 text-#{color}-500"

      svg_html = case key
      when "technique"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.59 14.37a6 6 0 01-5.84 7.38v-4.82m5.84-2.56a12.025 12.025 0 01-4.25 6.01M15.59 14.37a12.025 12.025 0 00-4.25 6.01M19.11 10.37a12.025 12.025 0 01-4.25 6.01M19.11 10.37c-.38.82-.82 1.6-1.32 2.32M19.11 10.37a12.015 12.015 0 00-4.474-5.33M15.59 14.37a12.036 12.036 0 00-4.474-5.33" /></svg>'
      when "endurance"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" /></svg>'
      when "power"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.042 21.672L13.684 16.6m0 0l-2.51 2.225.569-9.47 5.227 7.917-3.286-.672zm-7.518-.267A8.25 8.25 0 1120.25 10.5M8.288 14.212A8.25 8.25 0 1110.5 20.25" /></svg>'
      when "plans"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>'
      when "burn"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.362 5.214A8.252 8.252 0 0112 21 8.25 8.25 0 016.038 7.048 8.287 8.287 0 009 9.6a8.983 8.983 0 013.361-6.867 8.21 8.21 0 003 2.48z" /><path stroke-linecap="round" stroke-linejoin="round" d="M12 18a3.75 3.75 0 00.495-7.467 5.99 5.99 0 00-1.925 3.546 5.974 5.974 0 01-2.133-1A3.75 3.75 0 0012 18z" /></svg>'
      when "anywhere"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 1.5H8.25A2.25 2.25 0 006 3.75v16.5a2.25 2.25 0 002.25 2.25h7.5A2.25 2.25 0 0018 20.25V3.75a2.25 2.25 0 00-2.25-2.25H13.5m-3 0V3h3V1.5m-3 0h3m-3 18.75h3" /></svg>'
      when "strength"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12.75 8.25v-1.5a2.25 2.25 0 00-2.25-2.25H9.75a2.25 2.25 0 00-2.25 2.25v1.5m0 0l3 3m0 0l3-3m-3 3v1.5m6-4.5v-1.5a2.25 2.25 0 00-2.25-2.25H15a2.25 2.25 0 00-2.25 2.25v1.5m0 0l3 3m0 0l3-3m-3 3v1.5" /></svg>'
      when "motivation"
                  '<svg class="' + svg_class + '" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 18.75h-9a9.75 9.75 0 100-13.5h9a9.75 9.75 0 100 13.5z" /><path stroke-linecap="round" stroke-linejoin="round" d="M12.75 5.25v-1.5A2.25 2.25 0 0010.5 1.5h-1.5A2.25 2.25 0 006.75 3.75v1.5m0 0V21m0 0h-1.5a2.25 2.25 0 01-2.25-2.25v-1.5" /></svg>'
      else
                  ""
      end

      svg_html.html_safe
  end
end
