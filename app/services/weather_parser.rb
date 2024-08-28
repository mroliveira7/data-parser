class WeatherParser
  FIRST_LINE = 6
  LAST_LINE = 35
  COLUMN_VALUE = {
    "Dy" => 2..3,
    "MxT" => 5..7,
    "MnT" => 11..13,
    "AvT" => 15..19,
    "HDDay" => 21..27,
    "AvDP" => 29..33,
    "1HrP" => 35..39,
    "TPcpn" => 41..45,
    "WxType" => 46..52,
    "PDir" => 54..56,
    "AvSp" => 58..61,
    "Dir" => 63..65,
    "MxS" => 67..69,
    "SkyC" => 71..74,
    "MxR" => 76..78,
    "MnR" => 80..81,
    "AvSLP" => 83..89
  }.freeze

  def initialize(file_path)
    @file_path = file_path
    @columns = %w[Dy MxT MnT AvT HDDay AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP]
  end

  def parse_data
    lines = File.open(@file_path).readlines

    error = check_errors(lines)
    return error.merge({ results: [], total: 0 }) if error[:error]

    results = lines[FIRST_LINE..LAST_LINE].map { |line| line_to_hash(line) }

    { total: results.size, error: false, results: results, columns: @columns }
  end

  def line_to_hash(str)
    hash = {}
    COLUMN_VALUE.each do |k, inteval|
      hash[k] = str[inteval].blank? ? nil : str[inteval].strip
    end

    hash
  end

  def check_errors(lines)
    file_columns = lines[4].split(" ")

    if (file_columns - @columns).present?
      return { error: true, error_message: "The file is not in the right format." }
    end

    { error: false, error_message: "" }
  end
end
