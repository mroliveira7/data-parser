class TrueLogicParser
  def initialize(content, file_path)
    @content = content
    @file_path = file_path
  end

  def parse
    parser = @content == "weather" ? WeatherParser.new(@file_path) : SoccerParser.new(@file_path)
    parser.parse_data
  end
end
