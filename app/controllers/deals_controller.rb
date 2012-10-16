class DealsController < ApplicationController
  before_filter :find, :only => [:find, :train, :show]

  def index
    @deals = Deal.current.includes(:category).limit(100)
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
