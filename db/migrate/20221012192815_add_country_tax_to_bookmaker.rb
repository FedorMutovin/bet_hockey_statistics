class AddCountryTaxToBookmaker < ActiveRecord::Migration[6.1]
  def change
    add_column :bookmakers, :country_tax_percentage, :decimal, null: false, default: 0.0
  end
end
