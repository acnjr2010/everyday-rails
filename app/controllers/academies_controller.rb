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

  def create
    @academy = Academy.new(academy_params)

    respond_to do |format|
      if @academy.save
        format.html { redirect_to @academy, notice: "Academy created" }
        format.json { render :show, status: :created, location: @academy }
      else
        format.html { render :new }
        format.json { render json: @academy.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @academy = Academy.find(params[:id])

    respond_to do |format|
      if @academy.update(academy_params)
        format.html { redirect_to @academy, notice: "Academy created" }
        format.json { render :show, status: :created, location: @academy }
      else
        format.html { render :edit }
        format.json { render json: @academy.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def academy_params
      params.require(:academy).permit(:academy_name, :director_name, :address, :phone, :email)
    end
end
