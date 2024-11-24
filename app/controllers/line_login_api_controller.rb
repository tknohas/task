class LineLoginApiController < ApplicationController
  allow_unauthenticated_access

  require 'net/http'
  require 'uri'

  def login
    session[:state] = SecureRandom.urlsafe_base64

    base_authorization_url = 'https://access.line.me/oauth2/v2.1/authorize'
    response_type = 'code'
    client_id = Rails.application.credentials.line_client_id
    redirect_uri = CGI.escape(line_login_api_callback_url)
    state = session[:state]
    scope = 'profile%20openid'

    authorization_url = "#{base_authorization_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"
    redirect_to authorization_url, allow_other_host: true
  end

  def callback
    if params[:state] == session[:state]
      line_user_info = get_line_user_id_and_name(params[:code])
      user = User.find_or_initialize_by(line_user_key: line_user_info[0], name: line_user_info[1])

      if user.save
        start_new_session_for user
        redirect_to tasks_path, notice: 'ログインしました'
      else
        redirect_to root_path, notice: 'ログインに失敗しました'
      end
    else
      redirect_to root_path, notice: '不正なアクセスです'
    end
  end

  private

  def get_line_user_id_and_name(code)
    line_user_id_token = get_line_user_id_token(code)
    return nil unless line_user_id_token.present?
    
    url = 'https://api.line.me/oauth2/v2.1/verify'
    options = {
      body: {
        id_token: line_user_id_token,
        client_id: Rails.application.credentials.line_client_id
      }
    }

    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(options[:body])

    response = http.request(request)

    if response.code == '200'
      [JSON.parse(response.body)['sub'], JSON.parse(response.body)['name']]
    else
      nil
    end
  end

  def get_line_user_id_token(code)
    url = 'https://api.line.me/oauth2/v2.1/token'
    redirect_uri = line_login_api_callback_url

    options = {
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      },
      body: {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: redirect_uri,
        client_id: Rails.application.credentials.line_client_id,
        client_secret: Rails.application.credentials.line_client_secret
      }
    }

    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.path)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.set_form_data(options[:body])

    response = http.request(request)

    if response.code == '200'
      JSON.parse(response.body)['id_token']
    else
      nil
    end
  end
end
