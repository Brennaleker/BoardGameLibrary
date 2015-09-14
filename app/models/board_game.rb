class BoardGame < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  scope :ordered_by_name, -> { order('board_games.title') }

  def self.time_search(time)
    where('max_time <= ?', time)
  end

  def self.player_search_max(players)
    where('max_players >= ?', players)
  end

  def self.player_search_min(players)
    where('min_players <= ?', players)
  end
end
