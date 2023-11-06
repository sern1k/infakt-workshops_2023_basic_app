require 'rails_helper'

describe 'show weather', type: :feature do
  # mockowanie pogody
  let(:weather_data) do
    {
      'location' => {
        'name' => 'Cracow'
      },
      'current' => {
        'condition' => {
          'text' => 'Sunny',
          'icon' => 'https://cdn.weatherapi.com/weather/64x64/day/113.png'
        },
        'temp_c' => 16
      }
    }
  end

  let(:weather_presenter) { WeatherPresenter.new(weather_data) }

  before do
    allow_any_instance_of(WeatherApiConnector).to receive(:weather_data).and_return(weather_data) # mockujemy dane pogodowe
    visit root_path
  end

  describe 'current location' do
    it 'should be Cracow' do
      expect(page).to have_text("Today's weather in #{weather_presenter.location} is")
    end
  end

  describe 'current temperature' do
    it 'should be 16 degrees' do
      expect(page).to have_text("is #{weather_presenter.temperature}°C")
    end
  end

  describe 'current weather description' do
    it 'should be displayed' do
      expect(page).to have_text(weather_presenter.description)
    end
  end

  describe 'current weather icon' do
    it 'should be displayed' do
      expect(page).to have_css("img[src*='#{weather_presenter.icon}']")
    end
  end

  describe 'encourage text' do
    it 'should be displayed' do
      expect(page).to have_text(weather_presenter.encourage_text)
    end
  end

  describe 'bad weather for reading outside' do
    context 'when weather is sunny but temperature is below 15°C' do
      before do
        weather_data['current']['temp_c'] = 10
      end

      it 'should not encourage reading outside' do
        expect(page).to have_text(I18n.t('weather_presenter.encourage_text.not_good_to_read_outside'))
      end
    end

    context 'when weather is not sunny' do
      before do
        weather_data['current']['condition']['text'] = 'Rainy'
      end

      it 'should not encourage reading outside' do
        expect(page).to have_text(I18n.t('weather_presenter.encourage_text.not_good_to_read_outside'))
      end
    end
  end
end
