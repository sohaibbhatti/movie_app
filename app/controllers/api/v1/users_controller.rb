class Api::V1::UsersController < ApplicationController
  respond_to :json

  def create
    content = parse_request_body
    return json_format_error unless content
    response = V1::UserService.create content
    render json: response.result.to_json, status: response.status
  end

  def update
    content = parse_request_body
    return json_format_error unless content
    response = V1::UserService.update params[:id], content
    render json: response.result.to_json, status: response.status
  end

  def destroy
    response = V1::UserService.delete params[:id]
    render json: response.result.to_json, status: response.status
  end

  def show
    response = V1::UserService.read params[:id]
    render json: response.result.to_json, status: response.status
  end
end
