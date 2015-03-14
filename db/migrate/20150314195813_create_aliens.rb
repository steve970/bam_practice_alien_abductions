class CreateAliens < ActiveRecord::Migration
  def change
    create_table :aliens do |t|
      t.string :species
      t.string :planet
    end
  end
end
