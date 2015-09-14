require 'rails_helper'

RSpec.describe BoardGamesController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the board games into @board_games" do
      board_game1, board_game2 = BoardGame.create!(title: "Dominion"), BoardGame.create!(title: "Sentinels of the Multiverse")
      get :index

      expect(BoardGame.all).to match_array([board_game1, board_game2])
    end
  end # end of describe

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      board_game = BoardGame.create(title: "Board Game")
      get :show, id: board_game.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "displays information related to the given record" do
      board_game = BoardGame.create(title: "Board Game")
      get :show, id: board_game.id
      expect(board_game.title).to eq 'Board Game'
    end
  end # end of describe block

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "valid board game params" do
      let(:board_game_params) do {
        board_game:{
          title: 'a title',
          creator: 'a creator',
          my_score: 9,
          description: 'a description'
        }
      }
      end

      it "creates a board game record" do
        post :create, board_game_params
        expect(BoardGame.count).to eq 1
      end

      it "redirects to the board game show page" do
        post :create, board_game_params
        expect(response).to redirect_to(board_game_path(assigns(:board_game)))
      end #
    end # end of let

    # negative test, board game params are invalid
    context "invalid board game params" do
      let(:board_game_params) do {
        board_game:{
          creator: 'Del the Creator',
          description: 'game information'
        }
      }
      end

      it "does not persist invalid records" do
        post :create, board_game_params
        expect(BoardGame.count).to eq 0
      end

      it "redirects to the #new page after input fails" do
        post :create, board_game_params
        expect(response).to redirect_to(new_board_game_path)
      end
    end #end of let
  end #end of describe block

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      board_game = BoardGame.create(title: "Board Game")
      get :edit, id: board_game.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      board_game = BoardGame.create(title: "Board Game")
      get :edit, id: board_game.id
      expect(board_game.title).to eq 'Board Game'
    end
  end

  describe "PUT #edit" do
    let(:board_game) {BoardGame.create(title: "Game Title")}
      it "updates an existing record" do
        post :update, id: board_game, board_game: {title: "Title"}
        board_game.reload
        expect(board_game.title).to eq("Title")
      end
  end #end of describe block

  describe "DELETE #destroy" do
    it "deletes the given Board game record" do
      board_game = BoardGame.create(title: "Board game")
      expect {
        delete :destroy, {:id => board_game.to_param}
      }.to change(BoardGame, :count).by(-1)
    end
  end # end of describe block

  # describe "GET #search" do
  #   it "finds results matching params" do
  #     board_game = BoardGame.create(title: "Board game", min_players: 2, max_players: 4, min_time: 20, max_time: 30)
  #     params[:time] = 30
  #     params[:players] = 3
  #     search
  #     expect(@results.count).to eq 1
  #   end
  # end

end # end of describe for Board Games Controller
