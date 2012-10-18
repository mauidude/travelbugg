class DealsController < ApplicationController
  before_filter :find, :only => [:find, :show]
  before_filter :get_deals, :only => [:index, :deals, :category]

  def index

  end

  def deals
    render :layout => false
  end

  def category
    render 'index'
  end

  def show
    redirect_to @deal.link
  end

  private
  def find
    @deal = Deal.find params[:id]
  end

  def get_deals
    @page = params[:page].to_i || 0
    @categories = Category.display

    unless params[:category].nil?
      @category = Category.from_param! params[:category].gsub(/-/, ' ')
      @deals = Deal.current.includes(:category).where(:category_id => @category.id).limit(20)
    else
      @deals = Deal.current.includes(:category).limit(20).offset(@page * 20)
    end
  end
end
