class AddCountryIdToPages < ActiveRecord::Migration[6.0]
  def change
    add_column  :pages, :country_id, :integer
  end
end
