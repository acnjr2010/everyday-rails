require 'rails_helper'

RSpec.describe AcademiesController, type: :controller do
  describe "GET #show" do
    it "assings the requested academy to @academy" do
      academy = create(:academy)
      get :show, params: { id: academy.id }

      expect(assigns(:academy)).to eq academy
    end

    it "renders the :show template" do
      academy = create(:academy)
      get :show, params: { id: academy.id }

      expect(response).to render_template :show
    end
  end

  describe "GET #index" do
    context "with params[:letter] " do
      xit "populates an array of academies starting with the letter" do
        another_academy = create(:academy, academy_name: "SOS Informática")
        other_academy = create(:academy, academy_name: "Tec Informática")
        get :index, params: { letter: "S" }

        expect(assigns(:academy)).to match_array([another_academy])
      end

      it "renders the :index template" do
        get :index, params: { letter: 'S' }

        expect(response).to render_template :index
      end
    end

    context "without params[:letter]" do
      xit "populates an array of all academies" do
        academy = create(:academy, academy_name: 'SOS Informatica')
        other_academy = create(:academy, academy_name: 'Tec Informatica')
        get :index

        expect(assigns(:academy)).to match_array([academy, other_academy])
      end

      it "renders the :index template" do
        get :index

        expect(response).to render_template :index
      end
    end
  end

  describe "GET #new" do
    it "assigns a new Academy to @academy" do
      get :new

      expect(assigns(:academy)).to be_a_new(Academy)
    end

    it "renders the :new template" do
      get :new

      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the request academy to @academy" do
      academy = create(:academy)
      get :edit, params: { id: academy.id }

      expect(assigns(:academy)).to eq academy
    end

    it "renders the :edit template" do
      academy = create(:academy)
      get :edit, params: { id: academy.id }

      expect(response).to render_template :edit
    end
  end
end
