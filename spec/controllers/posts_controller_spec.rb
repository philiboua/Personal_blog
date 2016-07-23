require 'rails_helper'

describe PostsController do 
  context "when user logged in" do 

    let(:authenticate_user) { create(:user) }
    before { login_with authenticate_user }

    describe "GET #new" do 
      before { get :new }
      
      it "assigns a new post object to the @post variable" do 
        expect(assigns(:post)).to be_a_new(Post)
      end 

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do 
      context "with valid attributes" do 

        it "saves the post to the database" do 
          expect{
            post :create, post: attributes_for(:post)
          }.to change(Post, :count).by(1)
        end

        it "redirects to posts#show" do 
          post :create, post: attributes_for(:post)
          expect( response ).to redirect_to post_path(assigns[:post])
        end
      end

      context " with invalid attributes" do 
        it "does not save the new post in the database" do 
          expect{
            post :create, post: attributes_for(:post, title: nil)
          }.not_to change(Post, :count)
        end

        it "re-renders the :new template" do 
          post :create, post: attributes_for(:post, title: nil )
          expect( response).to render_template :new 
        end
      end
    end

    describe "GET #edit" do 

      let(:post) { create(:post) }
      before { get :edit, id: post.title}

      it "assigns the requested post to @post variable" do 
        expect(assigns(:post)).to eq post
      end

      it "renders the edit template " do 
        expect( response ).to render_template(:edit)
      end
    end

    describe "PATCH #update" do
      
      let(:post) { create(:post, title: "I will become a web developer soon...") }
      before { allow(Post).to receive_message_chain(:friendly, :find).and_return(post)}

      context "with valid attributes" do 

        
        it "locates the requested @post" do 
          patch :update, id: post.to_param, post: attributes_for(:post)
          expect(assigns(:post)).to eq(post)
        end

        it "changes the @post attributes" do 
          patch :update, id: post.to_param, post: attributes_for(:post, title: 'how to test your rails app')
          expect(Post.first.title).to eq('how to test your rails app')
        end

        it "redirects to updated @post" do 
          patch :update, id: post.to_param, post: attributes_for(:post, title: 'how to test your rails app' )
          expect(response).to redirect_to(Post.last)
        end
      end

      context "with invalid attributes" do 

        before { allow(Post).to receive_message_chain(:friendly, :find).and_return(post)}

        it "locates the requested @post" do 
          patch :update, id: post.to_param, post: attributes_for(:post)
          expect(assigns(:post)).to eq(post)
        end

        it "does not change the @post attributes" do
          patch :update, id: post.to_param, post: attributes_for(:post, title: nil )
          expect(Post.first.title).to eq("I will become a web developer soon...") 
        end

        it "re-renders the :edit template" do 
          patch :update, id: post.to_param, post: attributes_for(:post, title: nil )
          expect( response).to render_template(:edit)
        end
      end 
    end

    describe "GET #index " do

      before { get :index }

      it "assigns the posts object to the @posts variable" do 
        post1 = create(:post, slug: 'ruby on rails')
        post2 = create(:post, slug: 'junior web developer')
        expect(assigns(:posts)).to match_array([post1, post2])
      end

      it "renders the index page" do 
        expect(response).to render_template(:index)
      end
    end

    describe "GET #manage_post " do

      before { get :manage_posts }

      it "assigns the posts object to the @posts variable" do 
        post1 = create(:post, slug: 'ruby on rails')
        post2 = create(:post, slug: 'junior web developer')
        expect(assigns(:posts)).to match_array([post1, post2])
      end

      it "renders the index page" do 
        expect(response).to render_template(:manage_posts)
      end
    end

    describe "DELETE #destroy" do 
      let(:post) { create(:post, title: "I will become a web developer soon...") }
      before { allow(Post).to receive_message_chain(:friendly, :find).and_return(post)}

      it "deletes the post with Ajax" do 
        expect{ 
          xhr :delete, :destroy, id: post.to_param
        }.to change(Post, :count).by(-1)
      end
    end

  end
end


