require 'httparty'

class BoardGamesController < ApplicationController
  def index
  board_games
    render :index
  end

  def show
    board_games
    locate_board_game
    find_expansions
    find_base_game
    render :show
  end

  # Add a new Board Game
  def new
    board_games
    @board_game = BoardGame.new(board_game_params[:board_game])
    title_collection
  end

  def create
    board_games
    @board_game = BoardGame.create(board_game_params[:board_game])
    call_bgg
    @board_game.bgg_score = @bgg_score
    if @board_game.save
      redirect_to board_game_path(@board_game.id)
    else
      flash[:errors] = error_messages(@board_game)
      redirect_to new_board_game_path
    end
  end

  # Update an existing Board Game
  def edit
    board_games
    locate_board_game
    title_collection
    render :edit
  end

  def update
    board_games
    locate_board_game
    @board_game.update(board_game_params[:board_game])
    redirect_to board_game_path
  end

  def destroy
    locate_board_game
    @board_game.destroy

    redirect_to home_path
  end

  def search
    board_games
    @board_games = BoardGame.all
    @results_by_time = BoardGame.time_search params[:time]
    @results_by_min_players = BoardGame.player_search_min params[:players]
    @results_by_max_players = BoardGame.player_search_max params[:players]
    @results = []
    if params[:time] == "" && params[:players] == ""
      flash.now[:error] = "You did not enter any search parameters."
    elsif params[:time] != "" && params[:players] != ""
      @results_by_time.each do |result|
        if @results_by_min_players.include?(result) && @results_by_max_players.include?(result)
          @results.push(result)
        end
      end
    elsif params[:players] != ""
      @results_by_min_players.each do |result|
        if @results_by_max_players.include?(result)
          @results.push(result)
        end
      end
    elsif params[:time] != ""
      @results = @results_by_time
    end
  end

  def board_games
    @board_games = BoardGame.all.ordered_by_name
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
   @bgg_result = HTTParty.get("http://www.boardgamegeek.com/xmlapi/search?search=#{@query}&exact=1")
   if @bgg_result["boardgames"]["boardgame"] != nil
     @bgg_result = @bgg_result["boardgames"]["boardgame"]
     if @bgg_result.class != Hash
       name = @bgg_result[0]["name"]["__content__"]
       if name == @board_game.title
         @bgg_id = @bgg_result[0]["objectid"]
         check_for_match
       end
     else
       name = @bgg_result["name"]["__content__"]
       if name == @board_game.title
         @bgg_id = @bgg_result["objectid"]
         check_for_match
       end
     end
    end
  end

  def check_bgg
    @query = params["title"]
    @bgg_result = HTTParty.get("http://www.boardgamegeek.com/xmlapi/search?search=#{@query}&exact=1")
    if @bgg_id = @bgg_result["boardgames"]["boardgame"]["objectid"]
      @bgg_game_result = HTTParty.get("http://www.boardgamegeek.com/xmlapi/boardgame/#{@bgg_id}?stats=1")
      @bgg_game_result = @bgg_game_result["boardgames"]["boardgame"]
      create_game
      redirect_to board_game_path(@board_game.id)
    else
      flash[:errors] = "no matches found"
      redirect_to new_board_game_path
    end
  end

  def create_game
    title = params["title"]
    if @bgg_game_result["boardgamedesigner"].count == 1
      creator = @bgg_game_result["boardgamedesigner"]["__content__"]
    else
      creator = ""
      last = @bgg_game_result["boardgamedesigner"].pop
      @bgg_game_result["boardgamedesigner"].each do |designer|
        creator += (designer["__content__"] + ", ")
      end
      creator += ("and " + last["__content__"])
    end
    description = @bgg_game_result["description"].gsub '<br/>', ''
    min_players = @bgg_game_result["minplayers"]
    max_players = @bgg_game_result["maxplayers"]
    min_time = @bgg_game_result["minplaytime"]
    max_time = @bgg_game_result["maxplaytime"]
    bgg_score = @bgg_game_result["statistics"]["ratings"]["average"]
    @board_game = BoardGame.create(title: title, creator: creator, description: description, min_players: min_players, max_players: max_players, min_time: min_time, max_time: max_time, bgg_score: bgg_score)
  end

  def check_for_match
    @bgg_game_result = HTTParty.get("http://www.boardgamegeek.com/xmlapi/boardgame/#{@bgg_id}?stats=1")
    @bgg_score = @bgg_game_result["boardgames"]["boardgame"]["statistics"]["ratings"]["average"]
  end

  def update_bgg_score
    @board_game.update(bgg_score: @bgg_score)
  end

  def title_collection
    @board_games = BoardGame.all
    @game_titles = [""]
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
