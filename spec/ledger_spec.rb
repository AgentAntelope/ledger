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

  describe '#account_total' do
    context 'for a ledger with no data' do
      subject { described_class.new(data: []) }

      it 'returns 0' do
        expect(subject.account_total(account_holder: 'foo')).to eq(0)
      end
    end

    context 'for a ledger with pre-sorted data' do
      let(:filepath) { 'spec/fixtures/simple_ledger.csv' }
      subject { described_class.from_csv(filepath: filepath) }

      context 'for an account holder with no entries' do
        it 'returns 0' do
          expect(subject.account_total(account_holder: 'foo')).to eq(0)
        end
      end

      context 'for an account holder with debits' do
        let(:account_holder) {'john'}
        it 'correctly calculates the total' do
          expect(subject.account_total(account_holder: account_holder)).to eq(-145.00)
        end
      end

      context 'for an account holder with credits' do
        let(:account_holder) {'supermarket'}
        it 'correctly calculates the total' do
          expect(subject.account_total(account_holder: account_holder)).to eq(20.00)
        end
      end

      context 'for an account holder with credits and debits' do
        let(:account_holder) {'mary'}
        it 'correctly calculates the total' do
          expect(subject.account_total(account_holder: account_holder)).to eq(25.00)
        end
      end

      describe 'specifying a specific date' do
        let(:date) { Date.parse('2015-01-16') }
        context 'for an account holder with debits' do
          let(:account_holder) {'john'}
          it 'correctly calculates the total' do
            expect(subject.account_total(account_holder: account_holder, date: date)).to eq(-125.00)
          end
        end

        context 'for an account holder with credits' do
          let(:account_holder) {'mary'}
          it 'correctly calculates the total' do
            expect(subject.account_total(account_holder: account_holder, date: date)).to eq(125.00)
          end
        end
      end
    end
  end
end
