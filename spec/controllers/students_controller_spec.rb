require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "GET #show" do
    it "assings the requested student to @student" do
      student = create(:student)
      get :show, params: { id: student, academy_id: student.academy_id }

      expect(assigns(:student)).to eq student
    end

    it "renders the :show template" do
      student = create(:student)
      get :show, params: { id: student, academy_id: student.academy_id }

      expect(response).to render_template :show
    end
  end

  describe "GET #index" do
    context "with params[:letter]" do
      it "renders the :index template" do
        academy = create(:academy)
        get :index, params: { academy_id: academy }

        expect(response).to render_template :index
      end
    end

    context "without params[:letter]" do
      xit "populates an array of all students" do
        academy = create(:academy)
        student = create(:student, academy: academy)
        other_student = create(:student, academy: academy)
        get :index, params: { academy_id: academy}

        expect(:students).to match_array([student, other_student])
      end

      it "render the :index template" do
        academy = create(:academy)
        get :index, params: { academy_id: academy }

        expect(response).to render_template :index
      end
    end
  end

  describe "GET #new" do
    it "assigns a new Student to @student" do
      academy = create(:academy)
      get :new, params: { academy_id: academy }

      expect(assigns(:student)).to be_a_new(Student)
    end

    it "renders the :new template" do
      academy = create(:academy)
      get :new, params: { academy_id: academy }

      expect(response).to render_template :new
    end
  end
















end
