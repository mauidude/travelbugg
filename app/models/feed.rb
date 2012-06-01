require 'rss'

class Feed < ActiveRecord::Base
  validates :url,
            :presence => true,
            :url => true

  def items
    fetch unless @feed

    @feed.items
  end

  private

  def fetch
    open(url) do |rss|
      @feed = RSS::Parser.parse(rss)
    end
  end
end
