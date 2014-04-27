class AddLargeImageToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :large_image, :string
  end
end
