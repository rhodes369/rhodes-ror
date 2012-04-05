class RemovePdfTable < ActiveRecord::Migration
  def up
    drop_table :pdfs
  end

  def down
    create_table :pdfs do |t|
      t.string :orig_filename

      t.timestamps
    end
  end
end
