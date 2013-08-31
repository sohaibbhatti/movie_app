require 'spec_helper'

describe V1::MovieService do
  describe '.create' do
    let(:movie_data) { FactoryGirl.attributes_for(:movie) }

    context 'creation success' do
      subject { V1::MovieService.create(movie_data) }
      specify { subject.status.should          == 201 }
      specify { subject.result.keys.should     =~ %w[id title genres year created_at updated_at] }
      specify { subject.result['title'].should == movie_data[:title] }
      specify { subject.result['year'].should  == movie_data[:year] }
      specify { subject.result['genre'].should == movie_data[:genre] }
    end

    context 'validation errors' do
      subject { V1::MovieService.create(title: nil) }
      specify { subject.status.should                  == 400 }
      specify { subject.result[:message].should        == 'Validation Failure' }
      specify { subject.result[:errors][:title].should  == 'can\'t be blank' }
    end
  end

  describe '.read' do
    context 'success' do
      let!(:movie) { FactoryGirl.create :movie }
      subject { V1::MovieService.read(movie.id) }
      specify { subject.status.should       == 200 }
      specify { subject.result['id'].should == movie.id }
    end

    context 'movie not found' do
      subject { V1::MovieService.read('en') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'movie not found' }
    end
  end
end
