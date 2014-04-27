class AddSmallImageToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :small_image, :string
  end
end
