require 'spec_helper'

describe OurSite do
  it "has a valid factory" do
    create(:our_site).should be_valid
  end
end
