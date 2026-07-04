require 'net/http'
require 'json'
require 'date'

# English weekday and month names to ensure consistent output regardless of system locale
DAYS = %w[Sun Mon Tue Wed Thu Fri Sat].freeze
MONTHS = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec].freeze

# Formats a Time object to "Day, DD Mon YYYY" (e.g., "Fri, 23 Apr 2021")
def format_local_date(time)
  day_name = DAYS[time.wday]
  day_str = sprintf('%02d', time.day)
  month_name = MONTHS[time.month - 1]
  "#{day_name}, #{day_str} #{month_name} #{time.year}"
end

# 1. Retrieve OpenWeatherMap API Key from Environment
api_key = ENV['OPENWEATHERMAP_API_KEY']

if api_key.nil? || api_key.strip.empty?
  # If running in an interactive terminal, prompt the user for the key
  if $stdin.tty?
    print "Enter OpenWeatherMap API Key: "
    api_key = $stdin.gets&.strip
  end
end

if api_key.nil? || api_key.strip.empty?
  puts "Error: OPENWEATHERMAP_API_KEY environment variable is not set."
  puts "Please run the script with: OPENWEATHERMAP_API_KEY=\"your_key\" ruby weather.rb"
  exit 1
end

# 2. Define API endpoint for Jakarta
city = "Jakarta"
uri = URI("https://api.openweathermap.org/data/2.5/forecast?q=#{URI.encode_www_form_component(city)}&units=metric&appid=#{api_key}")

# 3. Fetch Forecast Data from OpenWeatherMap API
begin
  response = Net::HTTP.get_response(uri)
  
  if response.code != "200"
    error_data = JSON.parse(response.body) rescue nil
    message = error_data ? error_data['message'] : response.message
    puts "Error: Failed to fetch weather data from OpenWeatherMap."
    puts "API Response: #{message} (Status Code: #{response.code})"
    exit 1
  end

  data = JSON.parse(response.body)
rescue SocketError
  puts "Error: Network connection error. Please check your internet connection."
  exit 1
rescue => e
  puts "An unexpected error occurred: #{e.message}"
  exit 1
end

# 4. Group Forecasts by Local Date
# We adjust the UTC timestamp using the city's timezone offset returned by the API.
timezone_offset = data['city']['timezone'] || 0
forecasts_by_date = {}

data['list'].each do |entry|
  local_time = Time.at(entry['dt'] + timezone_offset).utc
  date_key = local_time.strftime("%Y-%m-%d")
  
  forecasts_by_date[date_key] ||= []
  forecasts_by_date[date_key] << {
    time: local_time,
    temp: entry['main']['temp']
  }
end

# 5. Output Weather Forecast
puts "Weather Forecast:"

# Sort dates chronologically
forecasts_by_date.keys.sort.each do |date_key|
  day_forecasts = forecasts_by_date[date_key]
  
  # Select the forecast entry closest to 12:00 PM (midday) local time for the day
  target_time = Time.utc(*date_key.split('-').map(&:to_i), 12, 0, 0)
  closest = day_forecasts.min_by { |f| (f[:time] - target_time).abs }
  
  formatted_date = format_local_date(closest[:time])
  formatted_temp = sprintf("%.2f°C", closest[:temp])
  
  puts "#{formatted_date}: #{formatted_temp}"
end
