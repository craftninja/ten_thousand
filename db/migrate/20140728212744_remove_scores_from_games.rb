class RemoveScoresFromGames < ActiveRecord::Migration[4.2]
  def change
    remove_column :games, :total_score, :integer
    remove_column :games, :current_score, :integer
  end
end
