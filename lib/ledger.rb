require 'csv'
require 'pry'

class Ledger
  def self.from_csv(filepath:)
    csv = CSV.open(filepath)
    new(data: csv)
  end

  def initialize(data:)
    @raw_data = data
    process_data
  end

  def account_total(account_holder:, date: Date.today)
    transactions[account_holder].inject(&:+) || 0
  end

  private

  attr_reader :raw_data, :transactions

  def process_data
    # Any key value store would be good here, a hash is the simplest.
    @transactions ||= Hash.new([])
    raw_data.each do |date, from, to, amount|
      amount = amount.to_f
      transactions[from] += [-amount]
      transactions[to] += [amount]
    end
  end
end
