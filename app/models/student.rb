class Student < ApplicationRecord
  belongs_to :academy

  validates :name, :document, :email, :academy, presence: true
  validates_uniqueness_of :document, :email

  def infos
    [name, document, email].join(", ")
  end

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end
end
