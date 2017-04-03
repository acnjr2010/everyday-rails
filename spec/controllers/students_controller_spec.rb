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
  end
end
