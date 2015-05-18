class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      
      t.text :caption
      t.string :picture
      t.references :place
      t.timestamps
    end
  end
end
