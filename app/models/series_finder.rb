class SeriesFinder
  def self.find(series_name)
    puts '----> Perform search on thetvdb.com'
    tvdb = TvdbParty::Search.new('B29BEDF607BA7F7A')
    results = tvdb.search(series_name)
    result = tvdb.get_series_by_id(results.first["seriesid"])
    return if Series.find_by_tvdb_id(result.id)
    result_episodes = result.episodes

    puts "----> Creating series: #{result.name}"
    series = Series.new
    series.name = blank_check(result.name)
    series.overview = blank_check(result.overview)
    series.tvdb_id = result.id
    series.last_updated = Time.now
    series.save!

    result_episodes.each do |e|
      unless season = series.seasons.find { |s| s.number == e.season_number.to_i }
        puts "----> Creating season: #{e.season_number}"
        season = series.seasons.new
        season.number = e.season_number
        season.save!
      end

      puts "----> Creating episode: #{e.name}"
      episode = series.episodes.new
      episode.tvdb_id = e.id
      episode.name = blank_check(e.name)
      episode.number = e.number
      episode.overview = blank_check(e.overview)
      episode.last_updated = Time.now
      episode.season = season
      episode.save!
    end
  end

  private

  def self.blank_check(property)
    return 'n/a' if property.blank?
    property
  end
end
