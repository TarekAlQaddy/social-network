class Post < ApplicationRecord
  belongs_to :user

  has_attached_file :photo,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    hash_secret: "longSecretString"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  # def photo_url
  #   self.photo.url
  # end
end
