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
end
