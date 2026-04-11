class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: '3桁ハイフン4桁で半角文字列で入力してください' }
    validates :city
    validates :address_line
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: '10~11桁の数字で半角文字列(ハイフンなし）で入力してください' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)

    Address.create(postal_code: postal_code,
                   prefecture_id: prefecture_id,
                   city: city,
                   address_line: address_line,
                   building_name: building_name,
                   phone_number: phone_number,
                   purchase_id: purchase.id)
  end
end
