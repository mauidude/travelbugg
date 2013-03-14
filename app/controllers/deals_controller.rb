class DealsController < ApplicationController
  before_filter :load_category, only: :category
  before_filter :load_deal, only: :show
  before_filter :load_deals, only: [:index, :deals, :category]
  before_filter :load_categories

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def deals
    render layout: false
  end

  def category
    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def show
    redirect_to @deal.link
  end

  private
    def load_deal
      @deal = Deal.find(params[:id])
    end

    def load_categories
      @categories = Category.all
    end

    def load_category
      @category = Category.from_param(params[:category])
    end

    def load_deals
      @page = params[:page].to_i || 0

      if @category.present? 
        @deals = @category.deals.current.includes(:category).limit(20).offset(@page * 20).to_a
      else
        @deals = Deal.current.includes(:category).limit(20).offset(@page * 20).to_a
      end
    end
end
