class AddMetricsToStandardValues < ActiveRecord::Migration
  def change
    add_column :standard_values, :metrics, :float, default: 0
  end
end
