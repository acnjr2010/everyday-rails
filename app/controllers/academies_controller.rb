class AcademiesController < ApplicationController

  def index
    @academies = Academy.all
  end

  def show
    @academy = Academy.find(params[:id])
  end
end
