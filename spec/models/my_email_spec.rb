require 'rails_helper'

RSpec.describe MyEmail, type: :model do
  it{ should validate_presence_of :email }
  it{ should validate_uniqueness_of :email }

  it "should not create with invalid email" do
  	email = MyEmail.new(email: "jorge")
  	expect(email.valid?).to be_falsy
  end

  it "should not create with invalid email" do
  	email = MyEmail.new(email: "jorge@alfaro.com")
  	expect(email.valid?).to be_truthy
  end
end
