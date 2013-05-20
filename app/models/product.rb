class Product < ActiveRecord::Base
  attr_accessible :description, :genere, :image_url, :name, :platform, :price
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :genere, presence: true
  validates :image_url, presence: true
  validates :platform, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.01}

  private

   def ensure_not_referenced_by_any_line_item
   		if line_items.empty?
   			return true
   		else
   			errors.add(:base, 'Line Items Present')
   		end
   end
end
