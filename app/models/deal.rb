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
end
