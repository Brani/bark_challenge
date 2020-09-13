class Dog < ApplicationRecord
  has_many_attached :images

  # Note: this assumes all owners are application users
    # optional attribute added since we dont have owner information on all existing dog profiles
  belongs_to :user, optional: true

  alias_attribute :owner, :user
end
