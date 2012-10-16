require 'spec_helper'

describe Deal do
  describe "associations" do
    it { should belong_to :feed }
    it { should belong_to :category }
  end

  describe "validations" do
    it { should validate_presence_of :feed_id }
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_most(4000) }
    it { should ensure_length_of(:link).is_at_most(4000) }
    it { should validate_presence_of :published_at }

  end

  describe "mass assignment" do
    it { should allow_mass_assignment_of :feed }
    it { should allow_mass_assignment_of :title }
    it { should allow_mass_assignment_of :link }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :published_at }
  end
end
