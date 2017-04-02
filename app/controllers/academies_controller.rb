class AcademiesController < ApplicationController

  def index
    @academies = Academy.all
  end

  def new
    @academy = Academy.new
  end

  def show
    @academy = Academy.find(params[:id])
  end

  def edit
    @academy = Academy.find(params[:id])
  end
end
