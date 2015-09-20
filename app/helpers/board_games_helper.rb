module BoardGamesHelper

  def check_if_bgg_score
    if @board_game.bgg_score == nil
      return "not found"
    else
      return @board_game.bgg_score
    end
  end

end
