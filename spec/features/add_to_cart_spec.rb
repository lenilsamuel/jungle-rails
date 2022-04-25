require 'rails_helper'

RSpec.feature "Add to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    @user = User.new({
        name: "Lenil",
        email: "lenil@email.com",
        password: "password",
        password_confirmation: "password"
      })
      @user.save!
      # @user2 = User.authenticate_with_credentials("lenil@email.com", "password")
  end

  scenario "They can add to cart" do
    # ACT
    visit root_path
    visit '/login'

    fill_in 'email', :with => "lenil@email.com"
    fill_in 'password', :with => "password"
    click_button('Submit')
    save_screenshot
    # find('').click


    
    first('.product').click_on('Add')
    # save_screenshot


    expect(page).to have_content "My Cart (1)"

    

    # DEBUG / VERIFY
    save_screenshot

  end

end