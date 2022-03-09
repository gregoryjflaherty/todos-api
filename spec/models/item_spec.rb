require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'relationships' do
    it { should belong_to(:todo)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
  end
end
