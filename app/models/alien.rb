class Alien < ActiveRecord::Base
  has_many :abductions
  has_many :people, through: :abductions
end
