class Cart < ActiveRecord::Base
   attr_accessible :user_id, :product_id

   belongs_to :user
   belongs_to :product 

   validates :user_id, presence: true
   validates :product_id, presence: true
end
