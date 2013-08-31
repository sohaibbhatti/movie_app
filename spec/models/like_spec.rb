require 'spec_helper'

describe Like do
  it { should respond_to :user }
  it { should respond_to :movie }

  describe 'validations' do
    let(:user)  { FactoryGirl.create :user }
    let(:movie) { FactoryGirl.create :movie }

    specify 'a user can only like a movie once' do
      like = Like.create(user: user, movie: movie)
      new_like = Like.new(user: user, movie: movie)
      new_like.valid?.should be_false
      new_like.errors[:movie_id].should include 'movie has already been liked by the user'
    end

    it 'mandates the presence of a user' do
      like = Like.new
      like.valid?.should be_false
      like.errors[:user_id].should include 'can\'t be blank'
    end

    it 'mandates the presence of a movie' do
      like = Like.new
      like.valid?.should be_false
      like.errors[:movie_id].should include 'can\'t be blank'
    end
  end
end
