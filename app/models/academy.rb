class Academy < ApplicationRecord
  has_many :students

  validates :academy_name, :director_name, :address, :phone, :email, presence: true
  validates_uniqueness_of :academy_name, :email

  def name
    [academy_name, director_name].join(' ')
  end

  def infos
    [address, phone, email].join(', ')
  end

  def self.by_letter(letter)
    where("academy_name LIKE ?", "#{letter}%").order(:academy_name)
  end
end
