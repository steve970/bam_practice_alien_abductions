class Person < ActiveRecord::Base
  has_many :abductions
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
