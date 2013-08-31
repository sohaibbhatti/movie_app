require 'spec_helper'

describe 'Like API' do
  let!(:movie)    { FactoryGirl.create :movie }
  let!(:user)     { FactoryGirl.create :user }
  let(:new_movie) { FactoryGirl.create :movie }
  let(:new_user)  { FactoryGirl.create :user }

  it 'allows users to like movies' do
    post "api/v1/movies/#{movie.id}/users/#{user.id}/likes"
    like_id = JSON.load(response.body)['id']
    response.status.should == 201
  end

  it 'allows users to delete likes' do
    like = Like.create movie: movie, user: user
    delete "api/v1/likes/#{like.id}"
    response.status.should == 200
  end

  it 'allows to view liked movies of a user' do
    Like.create movie: movie, user: user
    Like.create movie: movie, user: new_user
    Like.create movie: new_movie, user: user
    get "api/v1/users/#{user.id}/likes"
    response.status.should == 200
    movie_ids =JSON.load(response.body).collect { |movie| movie['id'] }
    movie_ids.size.should == 2
    movie_ids.should      =~ [movie.id, new_movie.id]
  end

  it 'allows to view liked movies of a user' do
    Like.create movie: movie, user: user
    Like.create movie: new_movie, user: user
    Like.create movie: new_movie, user: new_user
    get "api/v1/movies/#{movie.id}/likes"
    response.status.should == 200
    user_ids =JSON.load(response.body).collect { |user| user['id'] }
    user_ids.size.should == 1
    user_ids.should      =~ [user.id]
  end
end
