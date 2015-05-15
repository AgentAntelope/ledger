require 'csv'
require 'pry'

class Ledger
  def self.from(filepath:)
    csv = CSV.open(filepath)
    new
  end
end
