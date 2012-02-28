class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :orig_filename
      t.string :thumb_filename

      t.timestamps
    end
  end
end
