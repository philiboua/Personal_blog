require 'rails_helper'

describe AppsController do 

  let(:authenticate_user) { create(:user) }
  before { login_with authenticate_user }

  describe "GET #new" do 
    before { get :new }

    it "assigns a new app object to the @app variable" do 
      expect(assigns(:app)).to be_a_new(App)
    end

    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do 
    context "with valid attributes" do 
        it "saves the app to the database" do 
          expect{
            post :create, app: attributes_for(:app)
          }.to change(App, :count).by(1)
        end

        it "redirects to apps#index" do 
          post :create, app: attributes_for(:app)
          expect( response ).to redirect_to(apps_path)
        end
      end

      context " with invalid attributes" do 
        it "does not save the new post in the database" do 
          expect{
            post :create, app: attributes_for(:app, name: nil)
          }.not_to change(App, :count)
        end

        it "re-renders the :new template" do 
          post :create, app: attributes_for(:app, name: nil )
          expect( response).to render_template :new 
        end
      end
    end

    describe "GET #edit" do 

      let(:app) { create(:app) }
      before { get :edit, id: app.id}

      it "assigns the requested post to @app variable" do 
        expect(assigns(:app)).to eq(app)
      end

      it "renders the edit template " do 
        expect( response ).to render_template(:edit)
      end
    end

    describe "PATCH #update" do 
      let(:app) { create(:app, name: 'how to test your rails app') }

      context "with valid attributes" do 
        
        it "locates the requested @app" do 
          patch :update, id: app, app: attributes_for(:app)
          expect(assigns(:app)).to eq(app)
        end

        it "changes the @app attributes" do 
          patch :update, id: app, app: attributes_for(:app, name: 'my new website')
          expect(App.first.name).to eq('my new website')
        end

        it "redirects to apps#index" do 
          patch :update, id: app, app: attributes_for(:app, name: 'my new website')
          expect(response).to redirect_to(apps_path)
        end
      end

      context "with invalid attributes" do 

        it "locates the requested @app" do 
          patch :update, id: app, app: attributes_for(:app)
          expect(assigns(:app)).to eq(app)
        end

        it "does not change the @app attributes" do
          patch :update, id: app, app: attributes_for(:app, name: nil )
          expect(App.first.name).to eq( 'how to test your rails app') 
        end

        it "re-renders the :edit template" do 
          patch :update, id: app, app: attributes_for(:app, name: nil )
          expect( response).to render_template(:edit)
        end
      end 
    end

    describe "DELETE #destroy" do 
      let(:app) { create(:app, name: "how to test a rails app") }
      before { allow(App).to receive(:find).and_return(app)}

      it "deletes the post with Ajax" do 
        expect{ 
          xhr :delete, :destroy, id: app
        }.to change(App, :count).by(-1)
      end
    end
  end

  


