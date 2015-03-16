class AliensController < ApplicationController

  def index
    @aliens = Alien.all
    @people = Person.all
  end

  def show
    @alien = Alien.find(params[:id])
  end

  def new
    @alien = Alien.new
  end

  def create
    @alien = Alien.new(alien_params)
    if @alien.save
      flash[:message] = "#{@alien.species} were successfully added!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @alien = Alien.find(params[:id])
  end

  def update
    @alien = Alien.find(params[:id])
    if @alien.update(alien_params)
      flash[:message] = "Alien was updated!"
      redirect_to @alien
    else
      render :edit
    end
  end

  def destroy
    alien = Alien.find(params[:id])
    alien.destroy
    flash[:message] =  "#{alien.species} were successfully destroyed"
    redirect_to root_path
  end

  private

  def alien_params
    params.require(:alien).permit(:species, :planet)
  end

end
