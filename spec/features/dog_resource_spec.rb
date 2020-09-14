require 'rails_helper'

describe 'Dog resource', type: :feature do
  let(:nonowner) { create(:user) }
  let(:dog) { create(:dog) }

  describe '#create' do
    it 'can create a profile and set creator as the user' do
      user = create(:user)
      allow_any_instance_of(DogsController).to receive(:current_user).and_return(user)
      visit new_dog_path
      fill_in 'Name', with: 'Speck'
      fill_in 'Description', with: 'Just a dog'
      attach_file 'Image', 'spec/fixtures/images/speck.jpg'
      click_button 'Create Dog'
      expect(Dog.count).to eq(1)
      expect(Dog.first.owner).to eq(user)
    end

    it 'can create a profile and attach multiple images' do
      visit new_dog_path
      fill_in 'Name', with: 'Doggie'
      fill_in 'Description', with: 'Just a dog'
      attach_file "Image", ['spec/fixtures/images/speck.jpg', 'spec/fixtures/images/speck2.jpg']
      click_button 'Create Dog'
      expect(Dog.count).to eq(1)
    end
  end

  describe '#edit' do
    it 'can edit a dog profile if the current user is the owner' do
      allow_any_instance_of(DogsController).to receive(:current_user).and_return(dog.owner)
      visit dog_path(dog)
      click_link "Edit #{dog.name}'s Profile"
      fill_in 'Name', with: 'Speck'
      click_button 'Update Dog'
      expect(dog.reload.name).to eq('Speck')
    end

    it 'cannot edit a dog profile if the current user is not the owner' do
      allow_any_instance_of(DogsController).to receive(:current_user).and_return(nonowner)
      visit dog_path(dog)
      expect(page).not_to have_link "Edit #{dog.name}'s Profile"
    end
  end

  describe '#delete' do
    it 'can delete a dog profile if the current user is the owner' do
      allow_any_instance_of(DogsController).to receive(:current_user).and_return(dog.owner)
      visit dog_path(dog)
      click_link "Delete #{dog.name}'s Profile"
      expect(Dog.count).to eq(0)
    end

    it 'cannot delete a dog profile if the current user is not the owner' do
      allow_any_instance_of(DogsController).to receive(:current_user).and_return(nonowner)
      visit dog_path(dog)
      expect(page).not_to have_link "Delete #{dog.name}'s Profile"
    end
  end
end

