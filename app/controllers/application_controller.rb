class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  def parse_request_body
    JSON.load(request.body.read)
  rescue
    false
  end

  def json_format_error
    render json: { message: 'Invalid JSON payload' }.to_json, status: 400
  end
end
