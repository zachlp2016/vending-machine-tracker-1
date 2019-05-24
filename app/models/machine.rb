class Machine < ApplicationRecord
  validates_presence_of :location

  belongs_to :owner
  has_many :snack_machines
  has_many :snacks, through: :snack_machines

  def average_price
    self.snacks.average("price::float")
  end
end
