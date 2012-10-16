
class Admin::DealsController < ApplicationController
  def train
    deal = Deal.untrained

    @deal_training = DealTraining.new(:deal => deal)
    @categories = Category.order :name
    @suggested_category_id = deal.classify
  end

  def train_deal
    DealTraining.create!(params[:deal_training])

    redirect_to train_admin_deals_path
  end

  def classify
     Deal.classify

    redirect_to root_path
  end
end
