class PeopleController < ApplicationController

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:message] = "#{@person.first_name} #{@person.last_name} was successfully added!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      flash[:message] = "Person was updated!"
      redirect_to @person
    else
      render :edit
    end
  end

  def destroy
    person = Person.find(params[:id])
    person.destroy
    flash[:message] = "#{person.first_name} #{person.last_name} has been killed!"
    redirect_to root_path
  end



  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :occupation)
  end


end
