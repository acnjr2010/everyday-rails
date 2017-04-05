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
        student = create(:student, academy_id: academy.id)
        other_student = create(:student, academy_id: academy.id)
        get :index, params: { academy_id: academy.id }

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

  describe "GET #edit" do
    it "assigns the request student to @student" do
      student = create(:student)
      get :edit, params: { id: student.id, academy_id: student.academy_id }

      expect(assigns(:student)).to eq student
    end

    it "renders the :edit template" do
      student = create(:student)
      get :edit, params: { id: student.id, academy_id: student.academy_id }

      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves a new student in database" do
        expect{
          post :create,
          params: { academy_id: create(:academy), student: attributes_for(:student) }
        }.to change(Student, :count).by(1)
      end

      it "redirects to student#show" do
        academy = create(:academy)
        student = attributes_for(:student)
        post :create,
        params: { academy_id: academy, student: student }

        expect(response).to redirect_to "/academies/#{academy.id}/students/1"
      end
    end

    context "when in a invalid attributes" do
      it "does not save the student in the database" do
        expect{
          post :create, params: { academy_id: create(:academy), student: attributes_for(:invalid_student) }
        }.not_to change(Student, :count)
      end

      it "re-renders the :new template" do
        post :create,
        params: { academy_id: create(:academy), student: attributes_for(:invalid_student) }

        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before :each do
      @academy = create(:academy)
      @student = create(:student,
        name: "Antonio Carlos",
        document: "852.369.741-85",
        academy: @academy
      )
    end

    context "valid attributes" do
      it "locates the requested @student" do
        patch :update, params: {
          id: @student, academy_id: @academy, student: attributes_for(:student)
        }

        expect(assigns(:student)).to eq @student
      end

      it "changes @student's attributes" do
        patch :update, params: {
          id: @student, academy_id: @academy, student: attributes_for(:student, name: 'Nogueira Junior', document: '523.698.741-98', academy_id: @academy)
        }
        @student.reload

        expect(@student.name).to eq 'Nogueira Junior'
        expect(@student.document).to eq '523.698.741-98'
      end

      it "redirects to the updated student" do
        patch :update,
        params: { id: @student, academy_id: @academy, student: attributes_for(:student) }

        expect(response).to redirect_to "/academies/#{@academy.id}/students/#{@student.id}"
      end
    end

    context "with invalid attributes" do
      it "does not change the student's attributes" do
        patch :update,
        params: {
          id: @student, academy_id: @academy,
          student: attributes_for(:student, name: "Dart Vader", document: nil)
        }
        @student.reload

        expect(@student.name).not_to eq 'Dart Vader'
        expect(@student.document).to eq '852.369.741-85'
      end

      it "re-renders the :edit template" do
        patch :update,
        params: {
          id: @student, academy_id: @academy,
          student: attributes_for(:invalid_student)
        }

        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @academy = create(:academy)
      @student = create(:student, academy_id: @academy.id)
    end

    it "delete the student" do
      expect{
        delete :destroy,
        params: { academy_id: @academy, id: @student }
      }.to change(Student, :count).by(-1)
    end

    it "redirects do student#index" do
      delete :destroy,
      params: { academy_id: @academy, id: @student }

      expect(response).to redirect_to @academy
    end
  end
end
