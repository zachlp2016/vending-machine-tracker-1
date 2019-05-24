require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snickers = Snack.create!(name: 'Snickers', price: '1.25')
    heath = Snack.create!(name: 'Heath', price: '1.25')
    butterfinger = Snack.create!(name: 'Butterfinger', price: '1.35')
    dons.snacks << [snickers, heath, butterfinger]


    visit machine_path(dons)
    expect(page).to have_content("Don's Mixed Drinks Vending Machine")

    within("#snack-id-#{snickers.id}") do
      expect(page).to have_content("Snack: Snickers")
      expect(page).to have_content("Price: #{snickers.price}")
    end

    within("#snack-id-#{heath.id}") do
      expect(page).to have_content("Snack: Heath")
      expect(page).to have_content("Price: #{heath.price}")
    end

    within("#snack-id-#{butterfinger.id}") do
      expect(page).to have_content("Snack: Butterfinger")
      expect(page).to have_content("Price: #{butterfinger.price}")
    end
  end

  it 'has average price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snickers = Snack.create!(name: 'Snickers', price: '1')
    heath = Snack.create!(name: 'Heath', price: '2')
    butterfinger = Snack.create!(name: 'Butterfinger', price: '3')
    dons.snacks << [snickers, heath, butterfinger]


    visit machine_path(dons)
    expect(page).to have_content("Average price: $2")
  end
end
