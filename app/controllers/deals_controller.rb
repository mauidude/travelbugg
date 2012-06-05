
class DealsController < ApplicationController
  def index
    @deals = Deal.current.limit(20)
  end

  def show
    @deal = Deal.find params[:id]

    redirect_to @deal.link
  end
end
