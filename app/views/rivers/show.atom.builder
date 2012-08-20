atom_feed do |feed|
  feed.title(@river.title)
  feed.updated(@river.recommendations.first.created_at)  if @river.recommendations.present?
  @recommendations.each do |recommendation|
    feed.entry(recommendation, :url => recommendation.intigi_url) do |entry|
      entry.title(recommendation.intigi_title)
      entry.content(recommendation.intigi_excerpt, :type => 'html')
    end
  end
end
