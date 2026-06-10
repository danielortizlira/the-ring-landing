module ApplicationHelper
  def app_name      = Brand::APP_NAME
  def company_name  = Brand::COMPANY_NAME
  def support_email = t("support_email")

  def policy_privacy_path
    I18n.locale == :es ? es_privacy_policy_path(locale: nil) : en_privacy_policy_path(locale: nil)
  end

  def policy_terms_path
    I18n.locale == :es ? es_terms_and_conditions_path(locale: nil) : en_terms_and_conditions_path(locale: nil)
  end
end
