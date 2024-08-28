class ParserController < ApplicationController
  def index
  end

  def import
    tl_parser = TrueLogicParser.new(params[:file_for], params[:file].path)
    @parsed_data = tl_parser.parse

    render(partial: "weather_data", status: :ok)
  end
end
