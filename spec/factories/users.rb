FactoryBot.define do
  factory :user do
    nickname { 'takotakosan' }
    email { 'test@example.com' }
    password { 'abc123' }
    password_confirmation { password }

    first_name { '田子' }
    last_name  { '太平洋' }

    first_name_kana { 'タコ' }
    last_name_kana  { 'タイヘイヨウ' }

    birthday { '1990-01-01' }
  end
end
