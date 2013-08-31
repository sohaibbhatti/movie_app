class Api::V1::LikesController < ApplicationController

  # POST /movies/:movie_id/users/:user_id/likes
  def create
    response = ::V1::LikeService.create params[:movie_id], params[:user_id]
    render json: response.result.to_json, status: response.status
  end

  # DELETE /likes/:id
  def destroy
    response = ::V1::LikeService.delete params[:id]
    render json: response.result.to_json, status: response.status
  end
end
