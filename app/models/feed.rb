require 'rss'
require 'benchmark'

class Feed < ActiveRecord::Base
  has_many :deals,
           :order => 'published_at DESC',
           :conditions => 'deleted_at IS NULL'

  validates :url,
            :presence => true,
            :url => true

  def items
    fetch unless @feed

    @feed.items
  end

  private

  def fetch
    Feed.benchmark "Downloading Feed #{url}" do
      open(url) do |rss|
        @feed = RSS::Parser.parse(rss)
      end
    end
  end
end
