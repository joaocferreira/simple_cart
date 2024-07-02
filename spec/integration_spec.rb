# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

# this specs are very volatile, feel free to delete when failing
RSpec.describe 'E2E' do
  specify do
    cart = Cart.new.add('GR1')

    expect(cart.total_price).to eq('3.11€')
  end

  specify do
    cart = Cart.new.add('SR1')

    expect(cart.total_price).to eq('5.00€')
  end

  specify do
    cart = Cart.new.add('CF1')

    expect(cart.total_price).to eq('11.23€')
  end

  context 'with discount rules' do
    describe 'CEO buy-one-get-one-free GR1' do
      specify do
        cart = Cart.new.add('GR1').add('GR1')

        expect(cart.total_price).to eq('3.11€')
      end
    end

    describe 'COO bulk SR1' do
      specify do
        cart = Cart.new.add('SR1').add('SR1').add('GR1').add('SR1')

        expect(cart.total_price).to eq('16.61€')
      end
    end

    describe 'VPE 2/3 CF1' do
      specify do
        cart = Cart.new.add('GR1').add('CF1').add('SR1').add('CF1').add('CF1')

        expect(cart.total_price).to eq('30.57€')
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
