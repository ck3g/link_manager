require "spec_helper"

describe Status do
  it "has a valid factory" do
    create(:status).should be_valid
  end
end
