# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


feeds = Feed.create([
    {:url => "http://www.travelzoo.com/airfare/rss/" },
    {:url => "http://www.cheaptickets.com/rss/topdeals-flights.rss.xml" },
    {:url => "http://www.cheaptickets.com/rss/cruises.rss.xml" }
])

feeds.each do |f|
  f.fetch
end