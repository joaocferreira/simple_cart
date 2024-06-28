# frozen_string_literal: true

RSpec.describe Cart do
  describe '.total' do
    context 'when no products were added' do
      it 'returns 0.00€'
    end

    context 'when products were added' do
      it 'returns expected total'
    end
  end
end
