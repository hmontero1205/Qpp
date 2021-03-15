require 'rails_helper'

RSpec.describe OfficeHourChannel, type: :channel do
  it "successfully subscribes" do
    subscribe
    expect(subscription).to be_confirmed
  end
end
