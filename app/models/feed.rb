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
    do_fetch unless @feed

    @feed.items
  end

  def fetch
    do_fetch unless @feed
  end

  private

  def do_fetch
    Feed.benchmark "Downloading Feed #{url}" do
      open(url) do |rss|
        @feed = RSS::Parser.parse(rss)
      end
    end

    unless self.new_record?
      Feed.benchmark "Saving Feed #{url}" do
        # create hash by id
        deals = Hash[self.deals.map { |d| [d.id, d]}]

        Feed.transaction do
          @feed.items.each do |item|

            #remove leading/trailing whitespace
            item.link.strip!
            item.description.strip!
            item.title.strip!

            # get the deal with that link
            deal = self.deals.where(:link => item.link).first

            if deal
              #remove from deleted deals
              deals.reject! { |k,v| k == deal.id }
            else
              #if it doesn't exist in our system, add it!

              self.deals.create(:link => item.link,
                  :description => item.description,
                  :title => item.title,
                  :feed => self,
                  :published_at => item.pubDate)
            end
          end

          deals.each do |id, d|
            d.deleted_at = DateTime.now
            d.save
          end
        end
      end
    end
  end
end
