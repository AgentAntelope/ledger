require 'csv'

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
    # This guard is here to ensure that we respect that everyone, even account
    # holders we don't know, start at 0.
    total_transactions(transactions: transactions[account_holder], date: date) || 0
  end

  private

  attr_reader :raw_data, :transactions

  def process_data
    # Any key value store would be good here, a hash is the simplest.
    @transactions ||= Hash.new([])
    raw_data.each do |date, from, to, amount|
      date = Date.parse(date)
      # it would be nice to use Money here, but it's not really needed yet.
      amount = amount.to_f
      transactions[from] += [{amount: -amount, date: date}]
      transactions[to] += [{amount: amount, date: date}]
    end
  end

  def total_transactions(transactions:, date:)
    applicable_transactions = transactions.select{|t| t[:date] <= date}
    applicable_transactions.map {|t| t[:amount]}.inject(&:+)
  end
end
