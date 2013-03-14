class Admin::DealsController < ApplicationController
  before_filter :load_deals, only: [:index, :deals, :category]

  def index

  end

  def deals
    render layout: false
  end

  def category
    render :index
  end

  def train
    n = Deal.untrained.count
    deal = Deal.untrained.order(:id).offset(rand * n).first

    @deal_training = DealTraining.new(deal: deal)
    @categories = Category.unscoped.order :name
    @suggested_category_id = deal.classify
  end

  def train_deal
    deal = DealTraining.find_or_initialize_by_deal_id(params[:deal_training][:deal_id])
    deal.assign_attributes(params[:deal_training])
    deal.save

    respond_to do |format|
      format.html { redirect_to train_admin_deals_path }
      format.js { render nothing: true  }
      format.json { render nothing: true }
    end
  end

  def classify
    Deal.classify!

    redirect_to root_path
  end

  def reclassify
    Deal.reclassify!

    redirect_to root_path
  end

  private
    def load_deals
      @page = params[:page].to_i || 0
      @categories = Category.unscoped

      unless params[:category].nil?
        @category = Category.from_param params[:category].gsub(/-/, ' ')
        @deals = @category.deals.current.includes(:category).limit(20)
      else
        @deals = Deal.current.includes(:category).limit(20).offset(@page * 20)
      end
    end
end
