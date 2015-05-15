require 'ledger'

describe Ledger do
  describe '.from_csv' do
    let(:filepath) { 'spec/fixtures/simple_ledger.csv' }

    it 'errors without correct arguments' do
      expect { described_class.from_csv }.to raise_error(ArgumentError)
    end

    it 'takes a filepath' do
      expect { described_class.from_csv(filepath: filepath) }.not_to raise_error
    end

    it 'returns a ledger' do
      expect(described_class.from_csv(filepath: filepath)).to be_a(described_class)
    end
  end

  describe '#initialize' do
    it 'errors without correct arguments' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'takes some data' do
      expect { described_class.new(data: []) }.not_to raise_error
    end
  end
end
