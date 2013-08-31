
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
end
