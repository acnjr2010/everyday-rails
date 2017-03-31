require 'rails_helper'

RSpec.describe Academy, type: :model do
  it "is valid academy_name, director_name, address, phone and email" do
    academy = Academy.new(
      academy_name: 'Fatec Praia Grande',
      director_name: 'Nelson',
      address: 'Praça 19 de maio, Praia Grande/SP',
      phone: '3425-9652',
      email: 'fatecpg@fatec.com.br'
    )

    expect(academy).to be_valid
  end

  it "is invalid without a academy_name" do
    academy = Academy.new(academy_name: nil)
    academy.valid?

    expect(academy.errors[:academy_name]).not_to include("can't be blank")
  end

  it "is invalid without a director_name" do
    academy = Academy.new(director_name: nil)
    academy.valid?

    expect(academy.errors[:director_name]).not_to include("can't be blank")
  end

  it "is invalid without a address" do
    academy = Academy.new(address: nil)
    academy.valid?

    expect(academy.errors[:address]).not_to include("can't be blank")
  end

  it "is invalid without a phone" do
    academy = Academy.new(phone: nil)
    academy.valid?

    expect(academy.errors[:phone]).not_to include("can't be blank")
  end

  it "is invalid without a email" do
    academy = Academy.new(email: nil)
    academy.valid?

    expect(academy.errors[:email]).not_to include("can't be blank")
  end

  it "is invalid with a duplicate academy_name" do
    Academy.create(
      academy_name: 'Fatec Praia Grande',
      director_name: 'Nelson',
      address: 'Praça 19 de maio, Praia Grande/SP',
      phone: '3425-9652',
      email: 'fatecpg@fatec.com.br'
    )
    academy = Academy.new(
      academy_name: 'Fatec Praia Grande',
      director_name: 'Nelson',
      address: 'Praça 19 de maio, Praia Grande/SP',
      phone: '3425-9652',
      email: 'fatecpg@fatec.com.br'
    )
    academy.valid?

    expect(academy.errors[:academy_name]).not_to include("has already been taken")
  end
end
