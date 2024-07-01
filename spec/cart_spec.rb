# frozen_string_literal: true

RSpec.describe Cart do
  describe '.total' do
    context 'when no products were added' do
      it 'returns 0.00€' do
        expect(subject.total_price).to eq('0.00€')
      end
    end

    context 'when products were added' do
      it 'returns expected total'
    end
  end
end
