class PeopleController < ApplicationController
  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.save
    redirect_to root_path, notice: "#{@person.full_name} was successfully added!"
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    @person.update(person_params)
    redirect_to person_path(@person), notice: 'Person was updated!'
  end

  def destroy
    person = Person.find(params[:id])
    person.destroy
    redirect_to root_path, notice: "#{person.full_name} has been killed!"
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :occupation)
  end
end
