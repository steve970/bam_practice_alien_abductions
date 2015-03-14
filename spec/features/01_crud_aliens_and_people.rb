require 'rails_helper'

feature 'Users can CRUD aliens and people' do

  before :each do
    @alien1 = Alien.create!(species: 'Martians', planet: 'Mars')
    @alien2 = Alien.create!(species: 'Daemonites', planet: 'Daemon')
    @person1 = Person.create!(first_name: 'Will', last_name: 'Smith', occupation: 'Actor')
    @person2 = Person.create!(first_name: 'Bob', last_name: 'Bobson', occupation: 'Farmer')
  end

  scenario 'index lists all aliens and people' do
    visit root_path

    expect(page).to have_content 'List of Aliens'
    expect(page).to have_content 'Martians from the planet Mars'
    expect(page).to have_content 'Daemonites from the planet Daemon'
    expect(page).to have_content 'List of People'
    expect(page).to have_content 'Will Smith - Actor'
    expect(page).to have_content 'Bob Bobson - Farmer'
  end

  scenario 'User can add a new Alien' do
    visit root_path
    click_link 'New Alien'

    expect(current_path).to eq new_alien_path
    expect(page).to have_content 'Add New Alien'

    fill_in 'Species', with: 'Kree'
    fill_in 'Planet', with: 'Hala'
    click_on 'Create Alien'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Kree were successfully added!'
    expect(page).to have_content 'Kree from the planet Hala'
  end

  scenario 'User can add a new Person' do
    visit root_path
    click_link 'New Person'

    expect(current_path).to eq new_person_path
    expect(page).to have_content 'Add New Person'

    fill_in 'First name', with: 'Dan'
    fill_in 'Last name', with: 'Dare'
    fill_in 'Occupation', with: 'Hero'
    click_on 'Create Person'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Dan Dare was successfully added!'
    expect(page).to have_content 'Dan Dare - Hero'
  end

  scenario 'index links to Alien show' do

    visit root_path
    click_link 'Martians from the planet Mars'

    expect(current_path).to eq alien_path(@alien1)
    expect(page).to have_content 'Species: Martians'
    expect(page).to have_content 'Planet: Mars'
    expect(find_link('Index')[:href]).to eq(root_path)
    expect(find_link('Edit')[:href]).to eq(edit_alien_path(@alien1))
    expect(find_link('Delete')[:href]).to eq(alien_path(@alien1))

  end

  scenario 'index links to Person show' do

    visit root_path
    click_link 'Will Smith - Actor'

    expect(current_path).to eq person_path(@person1)
    expect(page).to have_content 'First Name: Will'
    expect(page).to have_content 'Last Name: Smith'
    expect(page).to have_content 'Occupation: Actor'
    expect(find_link('Index')[:href]).to eq(root_path)
    expect(find_link('Edit')[:href]).to eq(edit_person_path(@person1))
    expect(find_link('Delete')[:href]).to eq(person_path(@person1))

  end

  scenario 'User can update Alien' do
    visit alien_path(@alien1)
    click_link 'Edit'
    expect(current_path).to eq edit_alien_path(@alien1)
    expect(page).to have_content 'Edit Alien'

    fill_in 'Species', with: 'Wookie'
    fill_in 'Planet', with: 'Kashyyyk'
    click_on 'Update Alien'

    expect(current_path).to eq alien_path(@alien1)
    expect(page).to have_content 'Alien was updated!'
    expect(page).to have_content 'Species: Wookie'
    expect(page).to have_content 'Planet: Kashyyyk'
    expect(page).to have_no_content 'Martians'
    expect(page).to have_no_content 'Mars'
  end

  scenario 'User can update Person' do
    visit person_path(@person1)
    click_link 'Edit'
    expect(current_path).to eq edit_person_path(@person1)
    expect(page).to have_content 'Edit Person'

    fill_in 'First name', with: 'Peter'
    fill_in 'Last name', with: 'Parker'
    fill_in 'Occupation', with: 'Spider-Man'
    click_on 'Update Person'

    expect(current_path).to eq person_path(@person1)
    expect(page).to have_content 'Person was updated!'
    expect(page).to have_content 'First Name: Peter'
    expect(page).to have_content 'Last Name: Parker'
    expect(page).to have_content 'Occupation: Spider-Man'
    expect(page).to have_no_content 'Will'
    expect(page).to have_no_content 'Smith'
    expect(page).to have_no_content 'Actor'
  end

  scenario 'User can delete Alien' do
    visit alien_path(@alien1)
    click_link 'Delete'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Martians were successfully destroyed'
    expect(page).to have_no_content 'Martians from the planet Mars'

    expect { @alien1.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'User can delete Person' do
    visit person_path(@person1)
    click_link 'Delete'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Will Smith has been killed!'
    expect(page).to have_no_content 'Will Smith - Actor'

    expect { @person1.reload }.to raise_error ActiveRecord::RecordNotFound
  end

end
