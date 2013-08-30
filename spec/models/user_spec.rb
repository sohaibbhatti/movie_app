require 'spec_helper'

describe User do
  it { should respond_to :email }
  it { should respond_to :name }

  describe 'Validations' do
    let(:user) { User.new }

    it 'enforces the email always exists' do
      user.valid?
      user.errors[:email].should include 'can\'t be blank'
      user.email = 'john@doe.com' and user.valid?
      user.errors[:email].should be_blank
    end

    it 'enforces the uniqueness of email' do
      existing_user = FactoryGirl.create(:user)
      new_user     = User.new(email: existing_user.email)
      new_user.valid?
      new_user.errors[:email].should include'has already been taken'
    end

    it 'enforces the format of the email' do
      user.email = 'chewbacca'
      user.valid?
      user.errors[:email].should include 'incorrect format'
      user.email = 'john@doe.com'
      user.valid?
      user.errors[:email].should be_blank
    end

    it 'enforces the name always exists' do
      user.valid?
      user.errors[:name].should include 'can\'t be blank'
      user.name = 'John' and user.valid?
      user.errors[:name].should be_blank
    end
  end
end
