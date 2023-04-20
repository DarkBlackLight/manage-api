class ManageStorage < ApplicationRecord
  has_one_attached :storage

  def src
    storage.attached? ? url_for(storage) : nil
  end
end
