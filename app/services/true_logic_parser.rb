class TrueLogicParser
  PARSERS = {
    'weather' => WeatherParser,
    'soccer' => SoccerParser
  }.freeze

  def initialize(content, file_path)
    @content = content
    @file_path = file_path
  end

  def parse
    parser = PARSERS[@content].new(@file_path)
    parser.parse_data
  end
end
