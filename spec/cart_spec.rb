# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe Cart do
  describe '.total' do
    context 'when no products were added' do
      it 'returns 0.00€' do
        expect(subject.total_price).to eq('0.00€')
      end
    end

    context 'when products were added' do
      let(:products_repo) { instance_double(ProductRepo) }
      let(:subject) do
        described_class.new(products_repo: products_repo)
      end

      let(:product_a) do
        instance_double(
          Product,
          code: 'PA',
          price: BigDecimal('6.03')
        )
      end
      let(:product_b) do
        instance_double(
          Product,
          code: 'PB',
          price: BigDecimal('5.01')
        )
      end

      before :each do
        allow(products_repo).to receive(:find_by_code).with('PA').and_return(product_a)
        allow(products_repo).to receive(:find_by_code).with('PB').and_return(product_b)
      end

      context 'when it contains the same product' do
        it 'returns expected total' do
          cart = subject

          cart.add('PA')
          cart.add('PA')

          expect(subject.total_price).to eq('12.06€')
        end
      end

      context 'when it contains different products' do
        it 'returns expected total' do
          cart = subject.add('PA').add('PB').add('PA')

          expect(cart.total_price).to eq('17.07€')
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
