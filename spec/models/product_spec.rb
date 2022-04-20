require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "ensures that product name is present" do
      @category = Category.new(name: 'Video Games')
      @product = @category.products.new({
        name: 'Nintendo Switch',
        quantity: 4,
        price: '200'
      })
      expect(@product).to be_valid
    end
    it "is not valid without a name present" do
      @category = Category.new(name: 'Video Games')
      @product = @category.products.new({
        name: nil,
        quantity: 4,
        price: 200
      })
      expect(@product).to_not be_valid
      expect(@product.errors[:name]).to include("can't be blank")
    end
    it "is not valid without a price present" do
      @category = Category.new(name: 'Video Games')
      @product = @category.products.new({
        name: 'Switch',
        quantity: 4,
        price_cents: nil
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
    it "is not valid without a quantity present" do
      @category = Category.new(name: 'Video Games')
      @product = @category.products.new({
        name: 'Switch',
        quantity: nil,
        price_cents: 150
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
    it "is not valid without a quantity present" do
      @product = Product.new({
        name: 'Switch',
        quantity: nil,
        price_cents: 150
      })
      expect(@product).to_not be_valid
    end
  end
end
