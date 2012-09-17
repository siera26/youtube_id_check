class CreateYoutubeIds < ActiveRecord::Migration
  def change
    create_table :youtube_ids do |t|
      t.string :y_id, :limit => 50
      t.string :name

      t.timestamps
    end
  end
end
