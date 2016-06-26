FactoryGirl.define do
  factory :product do
    name "MyString"
    pricing "9.99"
    description "MyText"
    #asociacion con el facotory de user
    association :user, factory: :user
  end
end
