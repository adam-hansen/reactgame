class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :gameid
      t.integer :boardstate, array: true, default: []
      t.boolean :p1_is_next
      t.timestamps
    end
  end
end
