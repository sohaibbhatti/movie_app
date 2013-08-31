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
      specify { subject.result[:errors][:title].should == 'can\'t be blank' }
    end

    context 'mass assignment or invalid attributes' do
      subject { V1::MovieService.create(tiee: 'FLCL') }
      specify { subject.status.should           == 500 }
      specify { subject.result[:message].should == 'unknown attribute: tiee' }
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

  describe '.update' do
    let!(:movie) { FactoryGirl.create :movie }

    context 'updation success' do
      subject { V1::MovieService.update(movie.id, title: 'Rambo', genres: ['comedy']) }
      specify { subject.status.should           == 200 }
      specify { subject.result['title'].should  == 'Rambo' }
      specify { subject.result['genres'].should == ['comedy'] }

      it 'updates the record in the database' do
        old_genres = movie.genres
        expect {
          subject
        }.to change { movie.reload.genres }.to(['comedy'])
      end
    end

    context 'validation error' do
      subject { V1::MovieService.update(movie.id, title: nil) }
      specify { subject.status.should           == 400 }
      specify { subject.result[:message].should == 'Validation Failure' }
      specify { subject.result[:errors].should be_present }
    end

    context 'movie not found' do
      subject { V1::MovieService.update('en', title: 'Elysium') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'movie not found' }
    end


    context 'mass assignment or invalid attributes' do
      subject { V1::MovieService.update(movie.id, tiee: 'FLCL') }
      specify { subject.status.should           == 500 }
      specify { subject.result[:message].should == 'unknown attribute: tiee' }
    end
  end

  describe '.delete' do
    context 'success' do
      let!(:movie) { FactoryGirl.create :movie }
      subject { V1::MovieService.delete(movie.id) }
      specify { subject.status.should       == 200 }
      specify { subject.result['id'].should == movie.id }
    end

    context 'user not found' do
      subject { V1::MovieService.delete('en') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'movie not found' }
    end
  end
end
