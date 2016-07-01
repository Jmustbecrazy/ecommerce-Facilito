# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  status     :integer          default(0)
#  ip         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
