require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
    it {should belong_to :user}
  end

  context "methods" do
    before :each do
      @user = User.create(name: "regular_test_user",
                         address: "1163 S Dudley St",
                         city: "Lakewood",
                         state: "CO",
                         zip: "80232",
                         email: "campryan@comcast.net",
                         password: "password",
                         password_confirmation: "password",
                         role: 0)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)

      @order_2 = @user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 1)
      @item_order3 = @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 4)
      @item_order4 = @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2)

      @order_3 = @user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 2)
      @item_order5 = @order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 4)

      @order_4 = @user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 3)
      @item_order6 = @order_4.item_orders.create!(item: @tire, price: @tire.price, quantity: 4)
    end

    describe 'instance methods' do
      it '#grandtotal' do
        expect(@order_1.grandtotal).to eq(230)
      end

      it '#create_item_orders' do
        item1 = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        @order_1.create_item_orders({item1 => 2, pull_toy => 1})
        expect(@order_1.item_orders.count).to eq(4)
        expect(@order_1.item_orders[0].class).to eq(ItemOrder)
      end

      it '#total_item_quantity' do
        item1 = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        @order_1.create_item_orders({item1 => 2, pull_toy => 1})
        expect(@order_1.total_item_quantity).to eq(8)
      end
    end

    describe "class methods" do
      it '.gather' do
        expect(Order.gather(:packaged)).to eq([@order_2])
        expect(Order.gather(:pending)).to eq([@order_1])
        expect(Order.gather(:shipped)).to eq([@order_3])
        expect(Order.gather(:cancelled)).to eq([@order_4])
      end
    end
  end
end
