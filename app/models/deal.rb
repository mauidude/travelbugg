class Deal < ActiveRecord::Base
  belongs_to :feed
  has_and_belongs_to_many :categories

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

  def train(category)
    StuffClassifier::Bayes.open("Deals") do |cls|
      cls.tokenizer.preprocessing_regexps.merge!({
          /\b\$?[\d\,\.]+\b/ => ' ',
          /<.*?>/ => ' '
      })

      cls.tokenizer.ignore_words |= %w(January,February,March,April,May,June,July,August,September,October,November,December,
Jan,Feb,Mar,Apr,Jun,Jul,Aug,Sept,Sep,Oct,Nov,Dec,Sun,Mon,Tues,Wed,Thurs,Fri,Sat,Sun,
Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday,orbitz,travelzoo,travelocity,
expedia,hotwire,cheap,cheaptickets)

      cls.train(category.id, raw_text)
    end
  end

  def classify
    category_id = nil

    StuffClassifier::Bayes.open("Deals") do |cls|
      category_id = cls.classify(raw_text)
    end

    category_id
  end

  def self.current
    Deal.where("deleted_at IS NULL").order("published_at DESC")
  end

  private

  def raw_text
    [title, description].join(' ')
  end
end
