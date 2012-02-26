class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :title

      t.timestamps
    end
  end
end
