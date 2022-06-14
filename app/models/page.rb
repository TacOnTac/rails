class Page < ApplicationRecord
  belongs_to :category
  belongs_to :country
  has_one_attached :image, dependent: :destroy


  def premiers_trois_mots_de_contenu
  	content.split(" ")[0..2].join(" ")
  end

end
