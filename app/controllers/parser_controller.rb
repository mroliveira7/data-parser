class ParserController < ApplicationController
  def index
  end

  def import
    data = TrueLogicParser.new(params[:file_for], params[:file].path)
    @parsed_data = data.parse
    logger.debug(@parsed_data)

    redirect_to(action: "index")
  end
end
