class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  enum status: { unfulfilled: 0, fulfilled: 1 }

  def subtotal
    price * quantity
  end

  def replace_inventory
    item.inventory += quantity
  end

  def not_enough_inventory?
    quantity > item.inventory
  end

end
