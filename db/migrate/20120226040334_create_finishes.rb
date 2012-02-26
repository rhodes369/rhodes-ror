class CreateFinishes < ActiveRecord::Migration
  def change
    create_table :finishes do |t|
      t.string :title

      t.timestamps
    end
  end
end
