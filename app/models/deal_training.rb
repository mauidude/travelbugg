class DealTraining < ActiveRecord::Base
  after_create  :train

  belongs_to :deal
  belongs_to :category

  attr_accessible :deal, :category_id, :deal_id

  validates :deal,
            presence: true

  validates :category,
            presence: true

  private

    def train
      self.deal.train self.category
    end
end
