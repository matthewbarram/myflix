class ChangeFieldNameMovieUrlToUrl < ActiveRecord::Migration
  def change
    rename_column :videos, :movie_url, :url
  end
end
