require 'spec_helper'

describe Link do
  it "has a valid factory" do
    create(:link).should be_valid
  end
end
