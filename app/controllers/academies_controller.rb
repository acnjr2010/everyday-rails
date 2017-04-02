class AcademiesController < ApplicationController
  def show
    @academy = Academy.find(params[:id])
  end
end
