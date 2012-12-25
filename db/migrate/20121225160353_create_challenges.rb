class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :challenge_name
      t.string :point_value

      t.timestamps
    end
  end
end
