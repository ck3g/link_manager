require 'spec_helper'

describe Placement do
  it 'has a valid factory' do
    create(:placement).should be_valid
  end
end
