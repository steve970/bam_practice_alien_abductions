class AbductionsController < ApplicationController

  before_action do
    @alien = Alien.find(params[:alien_id])
  end

  def index
    @abductions = @alien.abductions
  end

  def new
    @abduction = @alien.abductions.new
  end

  def create
    @abduction = @alien.abductions.new(abduction_params)
    @abduction.save
    redirect_to alien_abductions_path(@alien), notice: "#{@alien.species} abducted #{@abduction.person.full_name}!"
  end

  def show
    @abduction = @alien.abductions.find(params[:id])
  end

  def edit
    @abduction = @alien.abductions.find(params[:id])
  end

  def update
    @abduction = @alien.abductions.find(params[:id])
    @abduction.update(abduction_params)
    redirect_to alien_abduction_path(@alien, @abduction), notice: 'Abduction was updated!'
  end

  def destroy
    @abduction = @alien.abductions.find(params[:id])
    @abduction.destroy
    redirect_to alien_abductions_path(@alien), notice: 'Forget this ever happened!'
  end

  private

  def abduction_params
    params.require(:abduction).permit(:person_id, :date, :anal_probe)
  end
end
