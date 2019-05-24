require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'instance-methods' do
    it 'should have average price' do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      snickers = Snack.create!(name: 'Snickers', price: '1')
      heath = Snack.create!(name: 'Heath', price: '2')
      butterfinger = Snack.create!(name: 'Butterfinger', price: '3')
      dons.snacks << [snickers, heath, butterfinger]
      expect(dons.average_price).to eq(2)
    end
  end
end
