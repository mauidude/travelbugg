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
    before :each do
      @feed = FactoryGirl.create :feed
    end
    subject { @feed }

    context "valid feed" do
      before :each do
        subject.should_receive(:open).once.and_yield(<<RSS
  <rss version="2.0">
  <channel>
  <title>Test channel</title>
  <link>http://www.google.com</link>
  <description>...text...</description>
  <item>
  <title>AirTran: Flights on sale - $173 round-trip</title>
  <link>
  http://www.cheaptickets.com/App/ViewAirDeal?deal_id=airtran-airways-flight-deal&WT.mc_id=crssf_top&WT.mc_ev=click
  </link>
  <description>
  ...text...
  </description>
  <category domain="Flights"/>
  <pubDate>Thu, 31 May 2012 17:10:55 CDT</pubDate>
  </item>
  <item>
  <title>Virgin America: Fare Sale - $185 round-trip</title>
  <link>
  http://www.cheaptickets.com/App/ViewAirDeal?deal_id=virgin-america-flight-deal&WT.mc_id=crssf_top&WT.mc_ev=click
  </link>
  <description>
  ...text...
  </description>
  <category domain="Flights"/>
  <pubDate>Thu, 31 May 2012 17:10:55 CDT</pubDate>
  </item>
  </channel>
  </rss>
RSS
        )

        deal1 = double("deal1")
          .should_receive(:link)
          .any_number_of_times
          .and_return("http://www.cheaptickets.com/App/ViewAirDeal?deal_id=airtran-airways-flight-deal&WT.mc_id=crssf_top&WT.mc_ev=click")

        deal1.should_receive(:id)
          .any_number_of_times
          .and_return(1)

        deal2 = double("deal2")
          .should_receive(:link)
          .any_number_of_times
          .and_return("http://www.cheaptickets.com/someotherlinknolongerinfeed")

        deal2.should_receive(:deleted_at=).once
        deal2.should_receive(:save).once
        deal1.should_not_receive(:deleted_at=)

        deals = double("deals")
        @feed.should_receive(:deals).any_number_of_times.and_return(deals)
        deals.should_receive(:map).once.and_return([[1, deal1], [2, deal2]])

        deals.should_receive(:create).once

        deals.should_receive(:where)
          .with(:link => "http://www.cheaptickets.com/App/ViewAirDeal?deal_id=airtran-airways-flight-deal&WT.mc_id=crssf_top&WT.mc_ev=click")
          .and_return([deal1])

        deals.should_receive(:where)
          .with(:link => "http://www.cheaptickets.com/App/ViewAirDeal?deal_id=virgin-america-flight-deal&WT.mc_id=crssf_top&WT.mc_ev=click")
          .and_return([nil])

      end

      its (:items) { should have(2).things }

      it "should have proper title" do
        subject.items[0].title.should eql("AirTran: Flights on sale - $173 round-trip")
      end

      it "should have proper description" do
        subject.items[0].description.should eql("...text...")
      end

      it "should have proper link" do
        subject.items[0].link.should eql("http://www.cheaptickets.com/App/ViewAirDeal?deal_id=airtran-airways-flight-deal&WT.mc_id=crssf_top&WT.mc_ev=click")
      end
    end

    pending "NEED TO CHECK deleting of deals from fetch"
  end
end
