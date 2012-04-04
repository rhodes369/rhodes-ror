class AddPaperclipColumnsToPdfs < ActiveRecord::Migration
  def self.up
    change_table :pdfs do |t|
      t.has_attached_file :pdf
    end
  end

  def self.down
    drop_attached_file :pdfs, :pdf
  end
end
