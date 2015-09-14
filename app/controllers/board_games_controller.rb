require 'httparty'

class BoardGamesController < ApplicationController
  def index
    @board_games = BoardGame.all.ordered_by_name
    render :index
  end

  def show
    locate_board_game
    find_expansions
    find_base_game
    render :show
  end

  # Add a new Board Game
  def new
    @board_game = BoardGame.new(board_game_params[:board_game])
    title_collection
  end

  def create
    @board_game = BoardGame.create(board_game_params[:board_game])
    call_bgg
    @board_game.bgg_score = @bgg_score
    if @board_game.save
      redirect_to board_game_path(@board_game.id)
    else
      flash[:error] = "You must include a title."
      redirect_to new_board_game_path
    end
  end

  # Update an existing Board Game
  def edit
    locate_board_game
    title_collection
    render :edit
  end

  def update
    locate_board_game
    @board_game.update(board_game_params[:board_game])
    redirect_to board_game_path
  end

  def destroy
    locate_board_game
    @board_game.destroy

    redirect_to home_path
  end

  def locate_board_game
    board_game_id = params[:id]
    @board_game = BoardGame.find(board_game_id)
  end

  def find_expansions
    @board_games = BoardGame.all
    @expansions = []
    @board_games.each do |game|
      if game.expansion_to == @board_game.title
        @expansions.push(game)
      end
    end
  end

  def find_base_game
    if @board_game.expansion == true
      @base_game = BoardGame.all.where(title: @board_game.expansion_to)[0]
    end
  end

  def call_bgg
   @query = @board_game.title
   @bgg_result = HTTParty.get("http://www.boardgamegeek.com/xmlapi/search?search=#{@query}")
   if @bgg_result["boardgames"]["boardgame"] != nil
     @bgg_result = @bgg_result["boardgames"]["boardgame"]
     @bgg_result.each do |game|
       name = game["name"]["__content__"]
       if name == @board_game.title
         @bgg_id = game["objectid"]
         @bgg_game_result = HTTParty.get("http://www.boardgamegeek.com/xmlapi/boardgame/#{@bgg_id}?stats=1")
         @bgg_score = @bgg_game_result["boardgames"]["boardgame"]["statistics"]["ratings"]["average"]
       end
      end
    end
  end

  def update_bgg_score
    @board_game.update(bgg_score: @bgg_score)
  end

  def title_collection
    @board_games = BoardGame.all
    @game_titles = []
    @board_games.each do |game|
      if game.expansion == false
        @game_titles.push(game.title)
      end
    end
    @game_titles.sort!
  end

  private

  def board_game_params
    params.permit(board_game: [:title, :description, :author, :stars])
  end

end
