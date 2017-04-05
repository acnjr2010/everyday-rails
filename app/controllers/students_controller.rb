class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @academy = Academy.find(params[:academy_id])
    @student = @academy.students.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to academy_student_path(@academy, @student), notice: "Student created" }
        format.json { render :json, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @academy = Academy.find(params[:academy_id])
    @student = @academy.students.find(params[:id])

    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to academy_student_path(@academy, @student), notice: "Student updated" }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @academy = Academy.find(params[:academy_id])
    @student = @academy.students.find(params[:id])
    @student.destroy
    respond_to do |format|
      format.html { redirect_to @academy, notice: "Student removed" }
      format.json { render json: @resource }
    end
  end

  private

    def student_params
      params.require(:student).permit(:name, :document, :email, :academy_id)
    end
end
