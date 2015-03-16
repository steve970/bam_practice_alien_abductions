class CreateAbductions < ActiveRecord::Migration
  def change
    create_table :abductions do |t|
      t.date :date
      t.boolean :anal_probe
      t.integer :person_id
      t.integer :alien_id
    end
  end
end
