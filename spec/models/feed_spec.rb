require 'spec_helper'

describe Feed do
  it { should validate_presence_of :url }
  it { should allow_value("http://www.test.com/rss.xml").for(:url) }
  it { should allow_value("https://www.test.com/rss.xml").for(:url) }
  it { should allow_value("www.test.com/rss.xml").for(:url) }
  it { should_not allow_value("test.com/rss.xml").for(:url) }

  describe "#items" do
    subject do
      FactoryGirl.create(:feed)
    end

    its (:items) { should_not be_empty }
  end
end
