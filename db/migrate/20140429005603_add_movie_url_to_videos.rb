class AddMovieUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :movie_url, :string
  end
end
