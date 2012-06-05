class Deal < ActiveRecord::Base
  belongs_to :feed

  attr_accessible :feed,
                  :title,
                  :link,
                  :description,
                  :published_at

  validates :feed_id,
            :presence => true

  validates :title,
            :presence => true,
            :length => { :maximum => 4000 }

  validates :link,
            :presence => true,
            :length => { :maximum => 4000 }

  validates :published_at,
            :presence => true

  def self.current
    Deal.where("deleted_at IS NULL").order("published_at DESC")
  end
end
