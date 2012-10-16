require 'spec_helper'

describe Category do
  describe "validations" do
    subject { FactoryGirl.create :category }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should ensure_length_of(:name).is_at_most(25) }
  end

  describe "mass assignment" do
    it { should allow_mass_assignment_of :name }
  end
end
