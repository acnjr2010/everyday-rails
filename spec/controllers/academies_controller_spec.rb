require 'rails_helper'

RSpec.describe AcademiesController, type: :controller do
  describe "administrator access" do
    login_user

    describe "GET #show" do
      before :each do
        @academy = create(:academy)
        get :show, params: { id: @academy.id }
      end

      it "assings the requested academy to @academy" do
        expect(assigns(:academy)).to eq @academy
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end

    describe "GET #index" do
      context "with params[:letter] " do
        it "renders the :index template" do
          get :index

          expect(response).to render_template :index
        end
      end

      context "without params[:letter]" do
        it "populates an array of all academies" do
          academy = create(:academy, academy_name: 'SOS Informatica')
          other_academy = create(:academy, academy_name: 'Tec Informatica')
          get :index

          expect(assigns(:academies)).to match_array([academy, other_academy])
        end

        it "renders the :index template" do
          get :index

          expect(response).to render_template :index
        end
      end
    end

    describe "GET #new" do
      before :each do
        get :new
      end

      it "assigns a new Academy to @academy" do
        expect(assigns(:academy)).to be_a_new(Academy)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      before :each do
        @academy = create(:academy)
        get :edit, params: { id: @academy.id }
      end

      it "assigns the request academy to @academy" do
        expect(assigns(:academy)).to eq @academy
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end

    describe "POST create" do
      context "with valid attributes" do
        it "saves the new academy in database" do
          expect{
            post :create, params: { academy: attributes_for(:academy) }
          }.to change(Academy, :count).by(1)
        end

        it "redirects to academy#show" do
          post :create, params: { academy: attributes_for(:academy) }

          expect(response).to redirect_to academy_path(assigns[:academy])
        end
      end

      context "with in a invalid attributes" do
        it "does not save the new academy in the database" do
          expect{
            post :create, params: { academy: attributes_for(:invalid_academy) }
          }.not_to change(Academy, :count)
        end

        it "re-renders the :new template" do
          post :create,
          params: { academy: attributes_for(:invalid_academy) }

          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before :each do
        @academy = create(:academy,
          academy_name: 'SOS Academy',
          director_name: 'Antonio Carlos'
        )
      end

      context "valid attributes" do
        it "locates the requested @academy" do
          patch :update, params: { id: @academy, academy: attributes_for(:academy) }

          expect(assigns(:academy)).to eq(@academy)
        end

        it "changes @academy's attributes" do
          patch :update,
          params: { id: @academy, academy: attributes_for(:academy, academy_name: 'TI Nogueira', director_name: 'Nogueira Junior') }
          @academy.reload

          expect(@academy.academy_name).to eq('TI Nogueira')
          expect(@academy.director_name).to eq('Nogueira Junior')
        end

        it "redirects to the updated academy " do
          patch :update,
          params: { id: @academy, academy: attributes_for(:academy) }

          expect(response).to redirect_to @academy
        end
      end

      context "with invalid attributes" do
        it "does not change the academy's attributes" do
          patch :update,
          params: { id: @academy, academy: attributes_for(:academy, academy_name: 'TI Academy', director_name: nil) }
          @academy.reload

          expect(@academy.academy_name).not_to eq 'TI Academy'
          expect(@academy.director_name).to eq 'Antonio Carlos'
        end

        it "re-renders the :edit template" do
          patch :update,
          params: { id: @academy, academy: attributes_for(:invalid_academy) }

          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before :each do
        @academy = create(:academy)
      end

      it "deletes the academy" do
        expect{
          delete :destroy,
          params: { id: @academy}
        }.to change(Academy, :count).by(-1)
      end

      it "redirects do academy#index" do
        delete :destroy,
        params: { id: @academy }

        expect(response).to redirect_to academies_url
      end
    end
  end

  describe "editor access" do
    login_user_editor

    describe "GET #show" do
      before :each do
        @academy = create(:academy)
        get :show, params: { id: @academy.id }
      end

      it "assings the requested academy to @academy" do
        expect(assigns(:academy)).to eq @academy
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end

  describe "GET #index" do
    login_user_editor

    context "with params[:letter] " do
      it "renders the :index template" do
        get :index

        expect(response).to render_template :index
      end
    end

    context "without params[:letter]" do
      it "populates an array of all academies" do
        academy = create(:academy, academy_name: 'SOS Informatica')
        other_academy = create(:academy, academy_name: 'Tec Informatica')
        get :index

        expect(assigns(:academies)).to match_array([academy, other_academy])
      end

      it "renders the :index template" do
        get :index

        expect(response).to render_template :index
      end
    end
  end

  describe "GET #new" do
    login_user_editor

    before :each do
      get :new
    end

    it "assigns a new Academy to @academy" do
      expect(assigns(:academy)).to be_a_new(Academy)
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    login_user_editor

    before :each do
      @academy = create(:academy)
      get :edit, params: { id: @academy.id }
    end

    it "assigns the request academy to @academy" do
      expect(assigns(:academy)).to eq @academy
    end

    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST create" do
    login_user_editor

    context "with valid attributes" do
      it "saves the new academy in database" do
        expect{
          post :create, params: { academy: attributes_for(:academy) }
        }.to change(Academy, :count).by(1)
      end

      it "redirects to academy#show" do
        post :create, params: { academy: attributes_for(:academy) }

        expect(response).to redirect_to academy_path(assigns[:academy])
      end
    end

    context "with in a invalid attributes" do
      it "does not save the new academy in the database" do
        expect{
          post :create, params: { academy: attributes_for(:invalid_academy) }
        }.not_to change(Academy, :count)
      end

      it "re-renders the :new template" do
        post :create,
        params: { academy: attributes_for(:invalid_academy) }

        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    login_user_editor

    before :each do
      @academy = create(:academy,
        academy_name: 'SOS Academy',
        director_name: 'Antonio Carlos'
      )
    end

    context "valid attributes" do
      it "locates the requested @academy" do
        patch :update, params: { id: @academy, academy: attributes_for(:academy) }

        expect(assigns(:academy)).to eq(@academy)
      end

      it "changes @academy's attributes" do
        patch :update,
        params: { id: @academy, academy: attributes_for(:academy, academy_name: 'TI Nogueira', director_name: 'Nogueira Junior') }
        @academy.reload

        expect(@academy.academy_name).to eq('TI Nogueira')
        expect(@academy.director_name).to eq('Nogueira Junior')
      end

      it "redirects to the updated academy " do
        patch :update,
        params: { id: @academy, academy: attributes_for(:academy) }

        expect(response).to redirect_to @academy
      end
    end

    context "with invalid attributes" do
      it "does not change the academy's attributes" do
        patch :update,
        params: { id: @academy, academy: attributes_for(:academy, academy_name: 'TI Academy', director_name: nil) }
        @academy.reload

        expect(@academy.academy_name).not_to eq 'TI Academy'
        expect(@academy.director_name).to eq 'Antonio Carlos'
      end

      it "re-renders the :edit template" do
        patch :update,
        params: { id: @academy, academy: attributes_for(:invalid_academy) }

        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    login_user_editor

    before :each do
      @academy = create(:academy)
    end

    it "deletes the academy" do
      expect{
        delete :destroy,
        params: { id: @academy}
      }.to change(Academy, :count).by(-1)
    end

    it "redirects do academy#index" do
      delete :destroy,
      params: { id: @academy }

      expect(response).to redirect_to academies_url
    end
  end
end
