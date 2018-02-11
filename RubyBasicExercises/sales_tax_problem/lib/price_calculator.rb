require_relative './item.rb'

class PriceCalculator

  def self.sales_tax(item)
    tax = 0
    case true
    when (item.import_status? && (!item.category?))
      tax = 0.15 * item.details[:price]
    when ((!item.import_status?) && (!item.category?))
      tax = 0.10 * item.details[:price]
    when (item.import_status? && item.category?)
      tax = 0.05 * item.details[:price]
    end
    item.details[:tax] = tax
  end

  def self.total_amount(items)
    items.inject(0) { |result, item| result += (item.details[:price] + item.details[:tax]) }
  end


end
