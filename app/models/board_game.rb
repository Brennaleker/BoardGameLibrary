class BoardGame < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

    scope :ordered_by_name, -> { order('board_games.title') }
end
