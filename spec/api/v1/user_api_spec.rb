require 'spec_helper'

describe 'User API' do
  it 'Allows the creation of users' do
    post 'api/v1/users', FactoryGirl.attributes_for(:user).to_json
    user_id = JSON.load(response.body)['id']
    response.status.should == 201
    get "api/v1/users/#{user_id}"
    response.status.should == 200
  end

  it 'notifies if the body is an invalid format' do
    post 'api/v1/users', FactoryGirl.attributes_for(:user)
    response.status.should == 400
    JSON.load(response.body)['message'].should == 'Invalid JSON payload'
  end

  it 'allows the updation of users' do
    user = FactoryGirl.create :user
    put "api/v1/users/#{user.id}", { name: 'Dario' }.to_json
    response.status.should == 200
    get "api/v1/users/#{user.id}"
    response.status.should == 200
    JSON.load(response.body)['id'].should == user.id
  end

  it 'allows the deletion of users' do
    user = FactoryGirl.create :user
    delete "api/v1/users/#{user.id}"
    response.status.should == 200
    get "api/v1/users/#{user.id}"
    response.status.should == 404
  end

  it 'displays information of a user' do
    user = FactoryGirl.create :user
    get "api/v1/users/#{user.id}"
    response.status.should                == 200
    JSON.load(response.body)['id'].should == user.id
  end
end
