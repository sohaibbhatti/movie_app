require 'spec_helper'

describe Movie do
  it { should respond_to :title }
  it { should respond_to :genres }
  it { should respond_to :year }

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
