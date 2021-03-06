module ApplicationHelper

  def show_rating(qi)
    if qi.video.review.blank?
      "No rating"
    else
      self.video.rating
    end
  end

  def options_for_video_reviews(selected=nil)
    options_for_select((1..5).map { |num| [pluralize(num, "star") , num]}, selected)
  end

  def video_review_rating_from_user(current_user, qi)
    current_user.reviews.where(video_id: "#{qi.video_id}").first.try(:rating)
  end

  def already_queue_item_for_video_and_user?(video, user)
    answer = QueueItem.get_queue_items_for_video_and_user(video, user)
    if answer == []
      false
    else
      true
    end
  end
end
