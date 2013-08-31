class Api::V1::MoviesController < ApplicationController

  # POST /movies
  def create
    content = parse_request_body
    return json_format_error unless content
    response = ::V1::MovieService.create content
    render json: response.result.to_json, status: response.status
  end

  # PUT /movies/:id
  def update
    content = parse_request_body
    return json_format_error unless content
    response = ::V1::MovieService.update params[:id], content
    render json: response.result.to_json, status: response.status
  end

  # DELETE /movies/:id
  def destroy
    response = ::V1::MovieService.delete params[:id]
    render json: response.result.to_json, status: response.status
  end

  # GET /movies/:id
  def show
    response = ::V1::MovieService.read params[:id]
    render json: response.result.to_json, status: response.status
  end

  # GET /movies/:id/likes
  def likes
    response = ::V1::LikeService.list_users_from_movie params[:id]
    render json: response.result.to_json, status: response.status
  end
end
