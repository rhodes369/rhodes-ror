class CreatePdfs < ActiveRecord::Migration
  def change
    create_table :pdfs do |t|
      t.string :orig_filename

      t.timestamps
    end
  end
end
