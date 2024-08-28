class ParserController < ApplicationController
  def index
  end

  def import
    tl_parser = TrueLogicParser.new(params[:file_for], params[:file].path)
    @parsed_data = tl_parser.parse

    calculate_temperature_infos

    render(partial: "weather_data", status: :ok)
  end

  private

  def calculate_temperature_infos
    @min_temp_spread = @parsed_data[:results].map { |r| [ r["Dy"], (r["MxT"].to_i - r["MnT"].to_i) ] }
                                             .min_by { |d| d[1] }

    @max_temp_spread = @parsed_data[:results].map { |r| [ r["Dy"], (r["MxT"].to_i - r["MnT"].to_i) ] }
                                             .max_by { |d| d[1] }
  end

  def calculate_premier_infos
  end
end
