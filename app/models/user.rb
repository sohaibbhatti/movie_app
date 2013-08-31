class User < ActiveRecord::Base
  #NOTE: Extract This if needed else where
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/

  validates :email, :name, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX, message: 'incorrect format' }

  def validation_error
    {
      message: 'Validation Failure',
      errors:  copy_errors
    }
  end

  private

  # returns a Hash of errors, attribute name  is the key, error description is in values
  def copy_errors
    errors = {}
    self.errors.each { |attrib, error| errors[attrib] = error }
    errors
  end
end
