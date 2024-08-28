class ParserController < ApplicationController
  def index
  end

  def import
    tl_parser = TrueLogicParser.new(params[:file_for], params[:file].path)
    @parsed_data = tl_parser.parse

    if @parsed_data[:error]
      return render(partial: "parsing_error", status: :bad_request)
    end

    case params[:file_for]
    when 'weather'
      calculate_temperature_infos
      render(partial: "weather_data", status: :ok)
    when 'soccer'
      calculate_premier_infos
      render(partial: "soccer_data", status: :ok)
    else
      render(partial: "parsing_error", status: :bad_request)
    end
  end

  private

  def calculate_temperature_infos
    @min_temp_spread = @parsed_data[:results].map { |r| [ r["Dy"], (r["MxT"].to_i - r["MnT"].to_i) ] }
                                             .min_by { |d| d[1] }

    @max_temp_spread = @parsed_data[:results].map { |r| [ r["Dy"], (r["MxT"].to_i - r["MnT"].to_i) ] }
                                             .max_by { |d| d[1] }
  end

  def calculate_premier_infos
    @min_team_spread = @parsed_data[:results].map { |r| [ r["Team"], (r["F"].to_i - r["A"].to_i).abs ] }
                                             .min_by { |d| d[1] }

    @max_team_spread = @parsed_data[:results].map { |r| [ r["Team"], (r["F"].to_i - r["A"].to_i).abs ] }
                                             .max_by { |d| d[1] }
  end
end
