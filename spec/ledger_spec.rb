require 'ledger'

describe Ledger do
  describe '.from' do
    let(:filepath) { 'spec/fixtures/simple_ledger.csv' }

    it 'errors without correct arguments' do
      expect { described_class.from }.to raise_error(ArgumentError)
    end

    it 'takes a filepath' do
      expect { described_class.from(filepath: filepath) }.not_to raise_error
    end

    it 'returns a ledger' do
      expect(described_class.from(filepath: filepath)).to be_a(described_class)
    end
  end
end
