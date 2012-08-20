class River < ActiveRecord::Base

  has_many :recommendations, :dependent => :destroy

  attr_accessible :body, :intigi_recommendations_url, :title, :intigi_popularity_threshold, :topsy_popularity_threshold, :is_featured

  scope :featured, where(:is_featured => true)

  def to_param
    "#{ id }-#{ title.parameterize }"
  end

  def fetch_recommendations_from_intigi(run_from_cron=false)

    response = HTTParty.get(intigi_recommendations_url, :basic_auth => {:username => ENV['INTIGI_API_KEY'], :password => "newsriver"})

    @existing_recommendations = []
    @new_recommendations = []

    response.each do |recommendation|

      # Hit Topsy API to determine the count. Only do this once since we use in two places.
      topsy_trackback_total = Topsy.trackbacks(recommendation['url'], :perpage => 1).trackback_total

      if self.recommendations.exists?(:intigi_title => recommendation['title'])

        # It exists, but update the popularity scores and show in river if necessary.
        existing_recommendation = self.recommendations.find_by_intigi_title(recommendation['title'])
        existing_recommendation.update_attribute(:intigi_popularity,recommendation['popularity'])
        existing_recommendation.update_attribute(:topsy_trackback_total,topsy_trackback_total)
        existing_recommendation.update_attribute(:show_in_river,true)  if existing_recommendation.meets_popularity_criteria? && !existing_recommendation.is_manually_hidden?

        @existing_recommendations << existing_recommendation

      else

        new_recommendation = self.recommendations.create(
          :intigi_url => recommendation['url'],
          :intigi_title => recommendation['title'],
          :intigi_excerpt => recommendation['excerpt'],
          :intigi_found_at => recommendation['found_at'],
          :intigi_host_name => recommendation['host_name'],
          :intigi_popularity => recommendation['popularity'],
          :intigi_word_count => recommendation['word_count'],
          :topsy_trackback_total => topsy_trackback_total,
        )

        new_recommendation.update_attribute(:show_in_river,true)  if new_recommendation.meets_popularity_criteria?

        @new_recommendations << new_recommendation

      end

      # TODO: Record date when we first mark a recommendation as visible in the stream and sort by that in the index view.
      # This will allow old recommendations previously found but not popular enough to get bumped to the top when tney meet the popularity threshold.

    end

    return @new_recommendations, @existing_recommendations  unless run_from_cron.eql?(true)

  end

  def self.fetch_all_recommendations_from_intigi(run_from_cron=false)
    River.all.each{|river| river.fetch_recommendations_from_intigi(run_from_cron)}
  end

end
