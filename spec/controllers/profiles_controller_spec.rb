require 'rails_helper'

describe ProfilesController do

  context "when user logged in" do 

    let(:authenticate_user) { create(:user) }
    before { login_with authenticate_user }

    describe "GET #new" do 

      before { get :new }
      
      it "assigns a new profile object to the @profile variable" do 
        expect(assigns(:profile)).to be_a_new(Profile)
      end 

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do 
      context "with valid attributes" do 
        it "saves the profile in the database" do 
          expect{ 
            post :create, profile: attributes_for(:profile)
          }.to change(Profile, :count).by(1)
        end

        it "renders the show page" do 
          post :create, profile: attributes_for(:profile)
          expect(response).to redirect_to profile_path(assigns[:profile])
        end
      end

      context "with invalid attributes" do 
        it "does not save the profile to the database" do 
          expect{ 
            post :create, profile: attributes_for(:profile, first_name: nil )
          }.not_to change(Profile,:count)
        end

        it "re-renders the show page " do 
          post :create, profile: attributes_for(:profile, first_name: nil)
          expect(response).to render_template(:new)
        end
      end
    end

    describe "GET #edit" do 
      let(:profile) { create(:profile) }
      before { get :edit, id: profile }

      it "assigns the requested profile to @profile variable " do
        expect(assigns(:profile)).to eq profile  
      end

      it "renders the edit template" do 
        expect(response).to render_template(:edit)
      end
    end

    describe "PATCH #update" do 
      let(:profile) { create(:profile, first_name: 'Philippe', last_name: 'Aka')}


      context "with valid attributes" do 

        it "locates the requested @profile" do
          patch :update, id: profile, profile: attributes_for(:profile)
          expect(assigns(:profile)).to eq(profile)
        end

        it "changes the @profile attributes" do 
          patch :update, id: profile, profile: attributes_for(:profile, first_name: 'David')
          expect(Profile.first.first_name).to eq('David')
        end

        it "redirects to updated @profile" do 
          patch :update, id: profile, profile: attributes_for(:profile, first_name: 'David')
          expect(response).to redirect_to(Profile.last)
        end
      end

      context "with invalid attributes" do 

        it "locates the requested @profile" do 
          patch :update, id: profile, profile: attributes_for(:profile)
          expect(assigns(:profile)).to eq(profile)
        end

        it "does not change the @profile attributes" do 
          patch :update, id: profile, profile: attributes_for(:profile, first_name: nil)
          expect(Profile.first.first_name).to eq('Philippe')
        end

        it "re-renders the edit template" do 
          patch :update, id: profile, profile: attributes_for(:profile, first_name: nil)
          expect(response).to render_template(:edit)
        end
      end
    end

  end

  context "when user logged out" do 

    before { login_with nil } 

    it "redirects to home page" do 
      get :new 
      expect(response).to redirect_to( new_user_session_path )
    end

  end

end


