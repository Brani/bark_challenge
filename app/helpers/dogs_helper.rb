module DogsHelper
  IMG_COUNT_BEFORE_AD = 2

  def display_ad?(dog_counter)
    dog_counter % IMG_COUNT_BEFORE_AD == 0 && dog_counter > 1
  end

  def is_owner?
    @dog.owner == current_user && current_user != nil
  end
end
