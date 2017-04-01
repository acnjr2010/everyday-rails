require 'rails_helper'

RSpec.describe Academy, type: :model do
  describe "validations" do

    context "validations invalid fields" do
      it "is invalid without a academy_name" do
        academy = Academy.new(academy_name: nil)
        academy.valid?

        expect(academy.errors[:academy_name]).to include("can't be blank")
      end

      it "is invalid without a director_name" do
        academy = Academy.new(director_name: nil)
        academy.valid?

        expect(academy.errors[:director_name]).to include("can't be blank")
      end

      it "is invalid without a address" do
        academy = Academy.new(address: nil)
        academy.valid?

        expect(academy.errors[:address]).to include("can't be blank")
      end

      it "is invalid without a phone" do
        academy = Academy.new(phone: nil)
        academy.valid?

        expect(academy.errors[:phone]).to include("can't be blank")
      end

      it "is invalid without a email" do
        academy = Academy.new(email: nil)
        academy.valid?

        expect(academy.errors[:email]).to include("can't be blank")
      end
    end
  end

  describe "" do
    before :each do
      @academy = Academy.create(
        academy_name: 'Fatec Praia Grande',
        director_name: 'Nelson',
        address: 'Praça 19 de maio, Praia Grande/SP',
        phone: '3425-9652',
        email: 'fatecpg@fatec.com.br'
      )
    end

    context "when " do
      it "is invalid with a duplicate academy_name" do
        other_academy = Academy.new(
          academy_name: 'Fatec Praia Grande',
          director_name: 'Nelson',
          address: 'Praça 19 de maio, Praia Grande/SP',
          phone: '3425-9652',
          email: 'fatecpg@fatec.com.br'
        )
        other_academy.valid?

        expect(other_academy.errors[:academy_name]).to include("has already been taken")
      end

      it "is invalid with a duplicate email" do
        other_academy = Academy.create(
          academy_name: 'Fatec Praia Grande',
          director_name: 'Nelson',
          address: 'Praça 19 de maio, Praia Grande/SP',
          phone: '3425-9652',
          email: 'fatecpg@fatec.com.br'
        )

        other_academy.valid?

        expect(other_academy.errors[:email]).to include("has already been taken")
      end

      it "return a academy_name and director_name as a string" do
        expect(@academy.name).to eq 'Fatec Praia Grande Nelson'
      end

      it "return a academy infos" do
        expect(@academy.infos).to eq 'Praça 19 de maio, Praia Grande/SP, 3425-9652, fatecpg@fatec.com.br'
      end

      it "returns a sorted array of results that match" do
        other_academy = Academy.create(
          academy_name: 'Uninove',
          director_name: 'Mercos',
          address: 'Rua Conselheiro Nébias, 200, Santos/SP',
          phone: '3425-9651',
          email: 'uninove@example2.com.br'
        )
        another_academy = Academy.create(
          academy_name: 'Fafesp',
          director_name: 'Maria',
          address: 'Rua dos Bombeiros, São Vicente/SP',
          phone: '3425-9650',
          email: 'fatecpg@fatec0.com.br'
        )

        expect(Academy.by_letter("F")).to eq [another_academy, @academy]
      end
    end

    context "validation valid fields" do
      it "is valid academy_name, director_name, address, phone and email" do
        expect(@academy).to be_valid
      end
    end
  end
end
