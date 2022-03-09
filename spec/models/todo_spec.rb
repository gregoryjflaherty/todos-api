require 'rails_helper'

RSpec.describe Todo, type: :model do

  describe 'relationships' do
    it {should have_many(:items).dependent(:destroy)}
  end

  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:created_by)}
  end
end
