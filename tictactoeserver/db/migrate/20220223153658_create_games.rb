class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :gameid
      t.text :boardstate, array: true, default: [].to_yaml
      t.boolean :p1_is_next
      t.timestamps
    end
  end
end
