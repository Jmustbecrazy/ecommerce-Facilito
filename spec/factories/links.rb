# == Schema Information
#
# Table name: links
#
#  id              :integer          not null, primary key
#  product_id      :integer
#  expiration_date :datetime
#  downloads       :integer
#  downloads_limit :integer
#  custom_id       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :string
#

FactoryGirl.define do
  factory :link do
    product nil
    expiration_date "2016-07-25 18:28:45"
    downloads 1
    downloads_limit 1
    custom_id "MyString"
  end
end
