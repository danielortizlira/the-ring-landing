require "net/http"

class AccountDeletionRequestsController < ApplicationController
  layout "forms"

  def new
    @email = nil
  end

  def create
    response = api_request(:post, "/account_deletion_requests.json",
                           { account_deletion_request: { email: deletion_params[:email] } })
    if success?(response)
      redirect_to delete_account_path, notice: t("account_deletion.confirmation_sent")
    else
      @email = deletion_params[:email]
      flash.now[:alert] = t("account_deletion.error", support_email: Brand::SUPPORT_EMAIL)
      render :new, status: :unprocessable_content
    end
  end

  def show
    @token = params[:token]
  end

  def destroy
    response = api_request(:delete, "/account_deletion_requests/#{params[:token]}.json")
    if success?(response)
      render :success
    elsif already_processed?(response)
      redirect_to delete_account_path, alert: t("account_deletion.already_processed")
    else
      redirect_to confirm_account_deletion_path(params[:token]), alert: t("account_deletion.error", support_email: Brand::SUPPORT_EMAIL)
    end
  end

  private

  def deletion_params
    params.require(:account_deletion_request).permit(:email, :confirm)
  end

  def api_request(method, path, body = nil)
    uri = URI("#{ENV["API_BASE_URL"]}#{path}")
    uri.query = URI.encode_www_form(locale: I18n.locale)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    req = Net::HTTP.const_get(method.to_s.capitalize).new(uri)
    req["Content-Type"] = "application/json"
    req.body = body.to_json if body
    http.request(req)
  rescue StandardError
    nil
  end

  def success?(response)
    response&.code&.start_with?("2")
  end

  def already_processed?(response)
    return false unless response

    JSON.parse(response.body)["error"] == "already_processed"
  rescue JSON::ParserError
    false
  end
end
