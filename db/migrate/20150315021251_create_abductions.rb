class CreateAbductions < ActiveRecord::Migration
  def change
    create_table :abductions do |t|
      t.integer :alien_id
      t.integer :person_id
      t.date :date
      t.boolean :anal_probe
    end
  end
end
