class Deal < ActiveRecord::Base
  belongs_to :feed

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
