require "rails_helper"

RSpec.describe "As an admin level user." do
  describe "When I visit a admin namespaced merchant index page." do
    before(:each) do
      @admin_user = User.create!(name: "Bob",
                                 address: "123 Glorious Way",
                                 city: "Stupendous",
                                 state: "SomeState",
                                 zip: '80122',
                                 email: "bob@example.com",
                                 password: "password",
                                 password_confirmation: "password",
                                 role: 2)
     @merchant1 = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
     @merchant2 = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
     @merchant3 = Merchant.create!(name: "Ryan's Art Shop", address: '125 Art Ave.', city: 'Littleton', state: 'CO', zip: 80232, enabled?: false)

     @item1 = @merchant1.items.create!(name: "bike_item1", description: "Description of Bike Item 1", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",active?: true, inventory: 12)
     @item2 = @merchant1.items.create!(name: "bike_item1", description: "Description of Bike Item 1", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",active?: true, inventory: 12)
     @item3 = @merchant1.items.create!(name: "bike_item1", description: "Description of Bike Item 1", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",active?: false, inventory: 12)
     @item4 = @merchant1.items.create!(name: "bike_item1", description: "Description of Bike Item 1", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",active?: false, inventory: 12)

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
     visit "/admin/merchants"
    end

    it "I can see 'disable' button next to all enabled merchants" do
      within("#merchant-#{@merchant1.id}") do
        expect(page).to have_button("Disable")
      end
      within("#merchant-#{@merchant2.id}") do
        expect(page).to have_button("Disable")
      end
      within("#merchant-#{@merchant3.id}") do
        expect(page).to have_no_button("Disable")
      end
    end

    it "I can click 'disable' button and disable the merchant" do
      within("#merchant-#{@merchant1.id}") do
        click_button "Disable"
      end

      within("#merchant-#{@merchant1.id}") do
        expect(page).to have_no_button("Disable")
      end
    end

    it "When I disable a merchant, that mercants items are inactive" do
      within("#merchant-#{@merchant1.id}") do
        expect(page).to have_button("Disable")
      end

      expect(@item1.active?).to eql(true)
      expect(@item2.active?).to eql(true)

      within("#merchant-#{@merchant1.id}") do
        click_button "Disable"
      end

      expect(@item1.active?).to eql(false)
      expect(@item2.active?).to eql(false)
    end
  end
end
