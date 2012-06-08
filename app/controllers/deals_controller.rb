class DealsController < ApplicationController
  before_filter :find, :only => [:find, :train]

  def index
    @deals = Deal.current.limit(100)#.offset(100).limit(100)
    @categories = Category.order('name')
  end

  def show
    redirect_to @deal.link
  end

  def train
    @category = Category.find params[:category_id]
    @deal.train @category

    redirect_to :action => :index
  end

  private

  def find
    @deal = Deal.find params[:id]
  end
end
