require 'spec_helper'

describe 'Movie API' do
  it 'allows the creation of movies' do
    post 'api/v1/movies', FactoryGirl.attributes_for(:movie).to_json
    movie_id = JSON.load(response.body)['id']
    response.status.should == 201
    get "api/v1/movies/#{movie_id}"
    response.status.should == 200
  end

  it 'allows the updation of movies' do
    movie = FactoryGirl.create :movie
    put "api/v1/movies/#{movie.id}", { title: 'Rambo' }.to_json
    response.status.should == 200
    get "api/v1/movies/#{movie.id}"
    response.status.should == 200
    JSON.load(response.body)['id'].should == movie.id
  end

  it 'allows the deletion of movies' do
    movie = FactoryGirl.create :movie
    delete "api/v1/movies/#{movie.id}"
    response.status.should == 200
    get "api/v1/movies/#{movie.id}"
    response.status.should == 404
  end

  it 'displays information of a movie' do
    movie = FactoryGirl.create :movie
    get "api/v1/movies/#{movie.id}"
    response.status.should == 200
    JSON.load(response.body)['id'].should == movie.id
  end
end
