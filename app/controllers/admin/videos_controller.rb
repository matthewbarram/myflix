class Admin::VideosController < AdminController

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "The video has been added."
    else
      flash[:danger] = "The video did not save. Please check your input and try again."
    end
    redirect_to new_admin_video_path
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id, :small_image, :small_cover_url, :large_cover_url, :large_image, :url)
  end
end
