require 'spec_helper'

describe V1::UserService do
  describe '.create' do
    let(:user_data) { FactoryGirl.attributes_for(:user) }

    context 'creation success' do
      subject { V1::UserService.create(user_data) }
      specify { subject[0].should          == 201 }
      specify { subject[1].keys.should     =~ %w[id name email created_at updated_at] }
      specify { subject[1]['name'].should  == user_data[:name] }
      specify { subject[1]['email'].should == user_data[:email] }
    end

    context 'validation errors' do
      subject { V1::UserService.create(email: 'boo radley') }
      specify { subject[0].should                  == 400 }
      specify { subject[1][:message].should        == 'Validation Failure' }
      specify { subject[1][:errors][:name].should  == 'can\'t be blank' }
      specify { subject[1][:errors][:email].should == 'incorrect format' }
    end
  end

  describe '.read' do
    context 'success' do
      let!(:user) { FactoryGirl.create :user }
      subject { V1::UserService.read(user.id) }
      specify { subject[0].should       == 200 }
      specify { subject[1]['id'].should == user.id }
    end

    context 'user not found' do
      subject { V1::UserService.read('en') }
      specify { subject[0].should           == 404 }
      specify { subject[1][:message].should == 'user not found' }
    end
  end
end
