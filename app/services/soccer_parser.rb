class SoccerParser
  FIRST_LINE = 3
  LAST_LINE = 23
  COLUMN_VALUE = {
    "Team" => 7..21,
    "P" => 23..27,
    "W" => 29..32,
    "L" => 34..36,
    "D" => 38..41,
    "F" => 43..45,
    "A" => 50..54,
    "Pts" => 56..57,
  }.freeze

  def initialize(file_path)
    @file_path = file_path
    @columns = %w[Team P W L D F A Pts]
  end

  def parse_data
    lines = File.open(@file_path).readlines

    error = check_errors(lines)
    return error.merge({ results: [], total: 0 }) if error[:error]

    results = lines[FIRST_LINE..LAST_LINE].map do |line|
      next if line.include?("---")

      line_to_hash(line)
    end

    results.compact!

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
    file_columns = lines[2].split(" ")

    if (file_columns - @columns).present?
      return { error: true, error_message: "The file is not in the right format." }
    end

    { error: false, error_message: "" }
  end
end
