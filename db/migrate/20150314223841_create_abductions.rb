class CreateAbductions < ActiveRecord::Migration
  def change
    create_table :abductions do |t|
      t.date :date
      t.boolean :anal_probe
      t.belongs_to :alien
      t.belongs_to :person
    end
  end
end
