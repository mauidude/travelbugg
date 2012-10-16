
class Admin::FeedsController < ApplicationController
  def import
      Feed.all.each do |feed|
        feed.fetch
      end
  end
end
