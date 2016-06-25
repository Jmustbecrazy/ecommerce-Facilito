require 'rails_helper'

RSpec.describe MyEmail, type: :model do
  it{ should validate_presence_of :email }
  it{ should validate_uniqueness_of :email }
end
