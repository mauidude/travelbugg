# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deal do
    feed
    title "$249 -- Paris: Upgraded Room at 4-Star Westin, 55% Off"
    description "Just steps from the luxe Place Vendome and Rue de Rivol<br />July 13 - Aug. 29; Oct. 31 - Dec. 26; book by June 8"
    link "http://www.travelzoo.com/hotels/international/-249-Paris-Upgraded-Room-at-4-Star-Westin-55-Off-1246719/"
    published_at DateTime.parse "Wed, 30 May 2012 14:54:00 GMT"
  end
end
