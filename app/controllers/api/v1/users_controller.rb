class Api::V1::UsersController < ApplicationController
  respond_to :json

  # POST /users
  def create
    content = parse_request_body
    return json_format_error unless content
    response = ::V1::UserService.create content
    render json: response.result.to_json, status: response.status
  end

  # PUT /users/:id
  def update
    content = parse_request_body
    return json_format_error unless content
    response = ::V1::UserService.update params[:id], content
    render json: response.result.to_json, status: response.status
  end

  # DELETE /users/:id
  def destroy
    response = ::V1::UserService.delete params[:id]
    render json: response.result.to_json, status: response.status
  end

  # get /users/:id
  def show
    response = ::V1::UserService.read params[:id]
    render json: response.result.to_json, status: response.status
  end
end
