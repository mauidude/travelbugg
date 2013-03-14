class DealsController < ApplicationController
  before_filter :load_deal, only: :show
  before_filter :load_deals, only: [:index, :deals, :category]

  def index

  end

  def deals
    render layout: false
  end

  def category
    render :index
  end

  def show
    redirect_to @deal.link
  end

  private
    def load_deal
      @deal = Deal.find(params[:id])
    end

    def load_deals
      @page = params[:page].to_i || 0
      @categories = Category.all

      unless params[:category].nil?
        @category = Category.from_param params[:category].gsub(/-/, ' ')
        @deals = @category.deals.current.limit(20)
      else
        @deals = Deal.current.includes(:category).limit(20).offset(@page * 20)
      end
    end
end
