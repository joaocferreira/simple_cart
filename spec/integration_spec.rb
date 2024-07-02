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
end

# rubocop:enable Metrics/BlockLength
