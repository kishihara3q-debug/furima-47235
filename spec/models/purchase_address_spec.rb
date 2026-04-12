require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)

    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
  end
  describe '商品購入配送先の登録' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it '郵便番号が空の場合に保存できないこと' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の形式でないと保存できないこと' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code 3桁ハイフン4桁で半角文字列で入力してください')
      end

      it '郵便番号に全角が含まれていると保存できないこと' do
        @purchase_address.postal_code = '１２３-４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code 3桁ハイフン4桁で半角文字列で入力してください')
      end

      it '都道府県が---の場合に保存できないこと' do
        @purchase_address.prefecture_id = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空の場合に保存できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空の場合に保存できないこと' do
        @purchase_address.address_line = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address line can't be blank")
      end

      it '電話番号が空の場合に保存できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が「10~11桁の数字」の形式でないと保存できないこと' do
        @purchase_address.phone_number = '1234567890123'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number 10~11桁の数字で半角文字列(ハイフンなし）で入力してください')
      end

      it '電話番号に全角が含まれていると保存できないこと' do
        @purchase_address.phone_number = '１２３４５６７８９０１２３'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number 10~11桁の数字で半角文字列(ハイフンなし）で入力してください')
      end

      it '電話番号にハイフンが含まれていると保存できないこと' do
        @purchase_address.phone_number = '090-1234-5678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number 10~11桁の数字で半角文字列(ハイフンなし）で入力してください')
      end

      it 'user_idが空の場合に保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空の場合に保存できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
