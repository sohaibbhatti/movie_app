require 'spec_helper'

describe V1::LikeService do
  let(:movie) { FactoryGirl.create :movie }
  let(:user)  { FactoryGirl.create :user }
  let(:like)  { FactoryGirl.create :like, user: user, movie: movie }

  describe '.create' do
    context 'creation success' do
      subject { V1::LikeService.create(movie.id, user.id) }
      specify { subject.status.should             == 201 }
      specify { subject.result.keys.should        =~ %w[id user_id movie_id created_at updated_at] }
      specify { subject.result['user_id'].should  == user.id }
      specify { subject.result['movie_id'].should == movie.id }
    end

    context 'validation errors' do
      before  { V1::LikeService.create(movie.id, user.id) }
      subject { V1::LikeService.create(movie.id, user.id) }
      specify { subject.status.should                     == 400 }
      specify { subject.result[:message].should           == 'Validation Failure' }
      specify { subject.result[:errors][:movie_id].should == 'movie has already been liked by the user' }
    end

    context 'user not found' do
      subject { V1::LikeService.create(movie.id, 'whoops') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'user not found' }
    end

    context 'movie not found' do
      subject { V1::LikeService.create('whoops', user.id) }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'movie not found' }
    end
  end

  describe '.delete' do
    context 'success' do
      before  { like }
      subject { V1::LikeService.delete(like.id) }
      specify { subject.status.should       == 200 }
      specify { subject.result['id'].should == like.id }
    end

    context 'like not found' do
      subject { V1::LikeService.delete('whoops') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'like not found' }
    end
  end

  describe '.list_users_from_movie' do
    context 'success - empty' do
      subject { V1::LikeService.list_users_from_movie(movie.id) }
      specify { subject.status.should == 200 }
      specify { subject.result.should == [] }
    end

    context 'success - present' do
      before  { like }
      subject { V1::LikeService.list_users_from_movie(movie.id) }
      specify { subject.status.should == 200 }
      specify { subject.result.should include user }
    end

    context 'movie not found' do
      subject { V1::LikeService.list_users_from_movie('whoops') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'movie not found' }
    end
  end

  describe '.movies_from_user' do
    context 'success - empty' do
      subject { V1::LikeService.list_movies_from_user(user.id) }
      specify { subject.status.should == 200 }
      specify { subject.result.should == [] }
    end

    context 'success - present' do
      before  { like }
      subject { V1::LikeService.list_movies_from_user(user.id) }
      specify { subject.status.should == 200 }
      specify { subject.result.should include movie }
    end


    context 'movie not found' do
      subject { V1::LikeService.list_movies_from_user('whoops') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'user not found' }
    end
  end
end
