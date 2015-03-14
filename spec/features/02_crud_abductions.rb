require 'rails_helper'

feature 'Users can crud abductions which belong to Aliens' do

  before :each do
    @alien1 = Alien.create!(species: 'Martians', planet: 'Mars')
    @alien2 = Alien.create!(species: 'Daemonites', planet: 'Daemon')
    @person1 = Person.create!(first_name: 'Will', last_name: 'Smith', occupation: 'Actor')
    @person2 = Person.create!(first_name: 'Bob', last_name: 'Bobson', occupation: 'Farmer')
    @person3 = Person.create!(first_name: 'Richie', last_name: 'Rich', occupation: 'Rich asshole')
    @abduction1 = Abduction.create!(alien_id: 1, person_id: 1, date: '03/20/2015', anal_probe?: false)
    @abduction1 = Abduction.create!(alien_id: 1, person_id: 2, date: '03/25/2015', anal_probe?: true)
  end

  scenario 'User can see on an Alien\'s show page how many abductions they have' do
    visit root_path
    click_link 'Martians from the planet Mars'

    expect(current_path).to eq alien_path(@alien1)
    expect(page).to have_content '2 Abductions'
  end

  scenario 'User can see index of an Alien\'s Abductions' do
    visit alien_path(@alien1)
    click_link '2 Abductions'

    expect(current_path).to eq alien_abductions_path(@alien1)
    expect(page).to have_content 'List of Abductions by Martians'
    expect(page).to have_content 'Will Smith on 03/20/2015 with no butt stuff'
    expect(page).to have_content 'Bob Bobson on 03/25/2015 with butt stuff'
    expect(find_link('Back'[:href]).to eq(alien_path(@alien1))
  end

  scenario 'User can add an abduction' do
    visit alien_abductions_path(@alien1)
    click_link 'New Abduction'

    expect(page).to have_content 'Add New Abduction'
    select @person3.name, from :abduction_person_id
    fill_in 'Date of Abduction', with: '03/16/2015'
    check 'anal_probe?'
    click_link 'Add Abduction'

    expect(current_path).to eq alien_abductions_path(@alien1)
    expect(page).to have_content 'Martians abducted Richie Rich!'
    expect(page).to have_content 'Richie Rich on 03/16/2015 with butt stuff'
  end

  scenario 'User can see a show page on an abduction' do
    visit alien_abductions_path(@alien1)
    click_link 'Will Smith on 03/20/2015 with no butt stuff'

    expect(current_path).to eq alien_abduction_path(@alien1, @abduction1)
    expect(page).to have_content 'Person Abducted: Will Smith'
    expect(page).to have_content 'Date of Abduction: 03/20/2015'
    expect(page).to have_content 'Was Person Anally Probed? False'
    expect(find_link('Index'[:href]).to eq(alien_abductions_path(@alien1))
    expect(find_link('Edit'[:href]).to eq(edit_alien_abduction_path(@alien1, @abduction1))
    expect(find_link('Delete'[:href]).to eq(alien_abduction_path(@alien1, @abduction1))
  end

  scenario 'User can update abduction information' do
    visit alien_abduction_path(@alien1, @abduction1)
    click_link 'Edit'
    expect(current_path).to eq edit_alien_abduction_path(@alien1, @abduction1)
    expect(page).to have_content 'Edit Abduction'
    check 'anal_probe?'
    click_link 'Update Abduction'

    expect(current_path).to eq alien_abduction_path(@alien1, @abduction1)
    expect(page).to have_content 'Abduction was updated!'
    expect(page).to have_content 'Was Person Anally Probed? True'
  end

  scenario 'User can delete Abduction' do
    visit alien_abduction_path(@alien1, @abduction1)
    click_link 'Delete'

    expect(current_path).to eq alien_abductions_path(@alien1)
    expect(page).to have_content 'Forget this ever happened!'
    expect(page).to have_no_content 'Will Smith on 03/20/2015 with no butt stuff'

    expect { @abduction1.reload }.to raise_error ActiveRecord::RecordNotFound
  end


end
