class Recommendation < ActiveRecord::Base

  belongs_to :river

  attr_accessible :intigi_excerpt, :intigi_found_at, :intigi_host_name, :intigi_popularity, :intigi_title, :intigi_url, :intigi_word_count, :topsy_trackback_total, :is_manually_hidden, :is_manually_starred

  scope :public, where(:show_in_river => true)
  scope :not_public, where(:show_in_river => false)
  scope :starred, where(:is_manually_starred => true)

  def meets_popularity_criteria?
    (intigi_popularity >= river.intigi_popularity_threshold) && (topsy_trackback_total >= river.topsy_popularity_threshold)
  end

end
