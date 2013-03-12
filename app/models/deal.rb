class Deal < ActiveRecord::Base
  belongs_to :feed
  belongs_to :category

  before_create :pre_classify

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
    StuffClassifier::TfIdf.open("Deals") do |cls|
      initialize_classifier cls

      cls.train(category.id, title)
    end
  end

  def classify
    category_id = nil

    StuffClassifier::TfIdf.open("Deals") do |cls|
      initialize_classifier cls

      category_id = cls.classify(title)
    end

    category_id
  end

  def self.current
    Deal.joins(:category).where("categories.display = true").where("deals.deleted_at IS NULL").order("deals.published_at DESC")
  end

  def self.untrained
    count = Deal.joins('LEFT OUTER JOIN deal_trainings on deal_trainings.deal_id = deals.id')
    .where('deal_trainings.id IS NULL')
    .where('char_length(deals.description) >= 10').count

    Deal.joins('LEFT OUTER JOIN deal_trainings on deal_trainings.deal_id = deals.id')
      .where('deal_trainings.id IS NULL')
      .where('char_length(deals.description) >= 10')
      .offset(rand count).first
  end

  def self.classify
    Deal.transaction do
      Deal.where('category_id IS NULL').each do |deal|
        deal.category_id = deal.classify
        deal.save
      end
    end
  end

  def self.reclassify
    Deal.transaction do
      Deal.all do |deal|
        deal.category_id = deal.classify
        deal.save
      end
    end
  end

  private

  def pre_classify
    self.category_id = self.classify
  end

  def initialize_classifier(cls)
    cls.tokenizer.preprocessing_regexps.merge!({
                                                   /\b\$?[\d\,\.]+[\%]?\b/ => ' ',
                                                   /<.*?>/ => ' '
                                               })
    cls.tokenizer.ignore_words |= %w(January,February,March,April,May,June,July,August,September,October,November,December,
Jan,Feb,Mar,Apr,Jun,Jul,Aug,Sept,Sep,Oct,Nov,Dec,Sun,Mon,Tues,Wed,Thurs,Fri,Sat,Sun,
Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday,orbitz,travelzoo,travelocity,
expedia,hotwire,cheap,cheaptickets,terms,apply,conditions)
  end

  def raw_text
    [title, description].join(' ')
  end
end
