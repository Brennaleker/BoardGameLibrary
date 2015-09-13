class BoardGamesController < ApplicationController
  def index
    @board_games = BoardGame.all.ordered_by_name
    render :index
  end

  def show
    locate_board_game
    find_expansions
    render :show
  end

  # Add a new Board Game
  def new
    @board_game = BoardGame.new(board_game_params[:board_game])
  end

  def create
    @board_game = BoardGame.create(board_game_params[:board_game])
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

    redirect_to board_games_path
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

  private

  def board_game_params
    params.permit(board_game: [:title, :description, :author, :stars])
  end

end
