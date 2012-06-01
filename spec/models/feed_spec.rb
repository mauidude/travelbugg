require 'spec_helper'

describe Feed do
  describe "associations" do
    it { should have_many(:deals).conditions('deleted_at IS NULL').order('published_at DESC') }
  end

  describe "validations" do
    it { should validate_presence_of :url }
    it { should allow_value("http://www.test.com/rss.xml").for(:url) }
    it { should allow_value("https://www.test.com/rss.xml").for(:url) }
    it { should allow_value("www.test.com/rss.xml").for(:url) }
    it { should_not allow_value("test.com/rss.xml").for(:url) }
  end

  describe "#items" do
    subject do
      FactoryGirl.create(:feed)
    end

    its (:items) { should_not be_empty }
  end
end
