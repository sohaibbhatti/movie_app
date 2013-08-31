require 'spec_helper'

describe V1::UserService do
  describe '.create' do
    let(:user_data) { FactoryGirl.attributes_for(:user) }

    context 'creation success' do
      subject { V1::UserService.create(user_data) }
      specify { subject.status.should          == 201 }
      specify { subject.result.keys.should     =~ %w[id name email created_at updated_at] }
      specify { subject.result['name'].should  == user_data[:name] }
      specify { subject.result['email'].should == user_data[:email] }
    end

    context 'validation errors' do
      subject { V1::UserService.create(email: 'boo radley') }
      specify { subject.status.should                  == 400 }
      specify { subject.result[:message].should        == 'Validation Failure' }
      specify { subject.result[:errors][:name].should  == 'can\'t be blank' }
      specify { subject.result[:errors][:email].should  == 'incorrect format' }
    end
  end

  describe '.read' do
    context 'success' do
      let!(:user) { FactoryGirl.create :user }
      subject { V1::UserService.read(user.id) }
      specify { subject.status.should       == 200 }
      specify { subject.result['id'].should == user.id }
    end

    context 'user not found' do
      subject { V1::UserService.read('en') }
      specify { subject.status.should           == 404 }
      specify { subject.result[:message].should == 'user not found' }
    end
  end
end
