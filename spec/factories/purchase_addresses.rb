FactoryBot.define do
  factory :purchase_address do
    postal_code { '000-0000' }
    prefecture_id { 1 }
    city { 'テスト市' }
    address_line { 'テスト住所' }
    phone_number { '09012345678' }
  end
end
