module TestData

  def self.create_test_data
    create_boston_legal
    create_fringe
  end

  def self.destroy_test_data
    Series.find_by_name('Boston Legal').destroy
    Series.find_by_name('Fringe').destroy
  end

  private

  def self.create_series(name)
    series = FactoryGirl.create :series, name: name
    season = FactoryGirl.create :season, series: series
    FactoryGirl.create_list :episode, 3, series: series, season: season
  end

  def self.create_boston_legal
    create_series 'Boston Legal'
  end

  def self.create_fringe
    create_series 'Fringe'
  end

end
