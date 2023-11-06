class WeatherPresenter
  THRESHOLD_FOR_READING_OUTSIDE = 15

  def initialize(data)
    @data = data
  end

  def current_data
    data['current']
  end

  def description
    current_data['condition']['text']
  end

  def temperature
    current_data['temp_c']
  end

  def icon
    current_data['condition']['icon']
  end

  def location
    data['location']['name']
  end

  def nice_weather?
    @description == 'Sunny' || @description == 'Partly cloudy'
  end

  def good_to_read_outside?
    nice_weather? && @temperature > THRESHOLD_FOR_READING_OUTSIDE
  end

  def encourage_text
    if good_to_read_outside?
      I18n.t('weather_presenter.encourage_text.good_to_read_outside')
    else
      I18n.t('weather_presenter.encourage_text.not_good_to_read_outside')
    end
  end

  private
    attr_reader :data
end
