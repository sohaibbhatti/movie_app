require 'spec_helper'
require 'service_response'

describe ServiceResponse do
  subject { ServiceResponse.new(200, { test: :foo }) }
  it { should respond_to :status }
  it { should respond_to :result }
end
