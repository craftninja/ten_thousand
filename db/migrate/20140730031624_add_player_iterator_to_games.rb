class AddPlayerIteratorToGames < ActiveRecord::Migration[4.2]
  def change
    add_column :games, :player_iterator, :integer
  end
end
