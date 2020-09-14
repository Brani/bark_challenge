module DogsHelper
  def display_ad?(dog_counter)
    dog_counter.even? && dog_counter > 1
  end
end
