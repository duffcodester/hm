class CreateCategoriesChallengesJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_challenges, id: false do |t|
      t.integer :category_id
      t.integer :challenge_id
    end
  end
end
