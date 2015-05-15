require 'csv'
require 'pry'

class Ledger
  def self.from_csv(filepath:)
    csv = CSV.open(filepath)
    new(data: csv)
  end

  def initialize(data:)
    @data = data
  end
end
