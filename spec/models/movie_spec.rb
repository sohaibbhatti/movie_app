require 'spec_helper'

describe Movie do
  it { should respond_to :title }
  it { should respond_to :genres }
  it { should respond_to :year }

  describe 'associations' do
    it { should respond_to :likes }
    it { should respond_to :users_liked_by }

    describe '.users_liked_by' do
      it 'returns users who have liked a movie' do
        movie     = FactoryGirl.create :movie
        user      = FactoryGirl.create :user
        new_user  = FactoryGirl.create :user

        user.likes.create movie: movie
        new_user.likes.create movie: movie

        movie.users_liked_by.should include user
        movie.users_liked_by.should include new_user
      end
    end
  end

  it 'serializes the genres attribute to an array' do
    Movie.new.genres.class.should == Array
  end

  describe 'validations' do
    let(:movie) { Movie.new }

    it 'enforces the title always exists' do
      movie.valid?
      movie.errors[:title].should include 'can\'t be blank'
      movie.title = 'Requiem for a Dream' and movie.valid?
      movie.errors[:title].should be_blank
    end
  end
end
