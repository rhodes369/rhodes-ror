class CreateNormalizedSpecifications < ActiveRecord::Migration
  def change
    # create_table :units do |t|
    #   t.string :imperial, :metric
    #   t.float :imperials_per_metric
    # end

    create_table :standards do |t|
      t.string :code, :description
      t.references :unit
    end
    
    create_table :standard_values do |t|
      t.references :standard, :material
      t.float :imperials
    end
    add_index :standard_values, :material_id
  end
end
