class Api::V1::MoviesController < ApplicationController

  # POST /movies
  def create
    content = JSON.load(request.body.read)
    response = V1::MovieService.create content
    render json: response.result.to_json, status: response.status
  end

  # PUT /movies/:id
  def update
    content = JSON.load(request.body.read)
    response = V1::MovieService.update params[:id], content
    render json: response.result.to_json, status: response.status
  end

  # DELETE /movies/:id
  def destroy
    response = V1::MovieService.delete params[:id]
    render json: response.result.to_json, status: response.status
  end

  # GET /movies/:id
  def show
    response = V1::MovieService.read params[:id]
    render json: response.result.to_json, status: response.status
  end
end
