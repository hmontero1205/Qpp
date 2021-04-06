require 'rails_helper'

RSpec.describe OfficeHourRecurrence, :type => :model do
  describe 'normalize' do
    it "Converts a map like {'monday' => '1', 'tuesday' => '1'} to a list of int days" do
      expect(OfficeHourRecurrence.normalize(monday: '1', tuesday: '1')).to eq [1, 2]
      expect(OfficeHourRecurrence.normalize(saturday: '1', sunday: '1')).to eq [6, 7]
      expect(OfficeHourRecurrence.normalize(saturday: '0')).to eq []
    end
  end

  describe 'de_normalize' do
    it 'Does the opposite of normalize' do
      expect(OfficeHourRecurrence.de_normalize [1,2]).to eq({'monday' => '1', 'tuesday' => '1'})
      expect(OfficeHourRecurrence.de_normalize []).to eq({})
    end
  end
end