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
  end

  context "when user logged out" do 

    before { login_with nil } 

    it "redirects to home page" do 
      get :new 
      expect(response).to redirect_to( new_user_session_path )
    end

  end

end



