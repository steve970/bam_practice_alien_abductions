class AliensController < ApplicationController
  def new
    @alien = Alien.new
  end

  def create
    @alien = Alien.new(alien_params)
    @alien.save
    redirect_to root_path, notice: "#{@alien.species} were successfully added!"
  end

  def show
    @alien = Alien.find(params[:id])
  end

  def edit
    @alien = Alien.find(params[:id])
  end

  def update
    @alien = Alien.find(params[:id])
    @alien.update(alien_params)
    redirect_to alien_path(@alien), notice: 'Alien was updated!'
  end

  def destroy
    alien = Alien.find(params[:id])
    alien.destroy
    redirect_to root_path, notice: "#{alien.species} were successfully destroyed"
  end

  private
  def alien_params
    params.require(:alien).permit(:species, :planet)
  end
end
