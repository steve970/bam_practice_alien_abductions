class WelcomeController < ApplicationController

  def index
    @aliens = Alien.all
    @people = Person.all
  end

end
