class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(enabled?: false)
    merchant.disable_items
    flash[:notice] = "#{merchant.name} is now disabled"
    redirect_to admin_merchants_path
  end

end
