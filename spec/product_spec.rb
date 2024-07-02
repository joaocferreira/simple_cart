# frozen_string_literal: true

RSpec.describe Product do
  let(:subject) do
    described_class.new('FOMO', 'Fear of missing out', 100_000)
  end

  it 'has expected getters' do
    expect(subject.product_code).to eq('FOMO')
    expect(subject.name).to eq('Fear of missing out')
    expect(subject.price).to eq(100_000)
  end
end
