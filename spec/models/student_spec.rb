require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "validation" do
    before :each do
      @academy = create(:academy)
    end
    context "validations valid input" do
      it "is a valid name, document and email" do
        student = create(:student, academy_id: @academy.id)
        student.valid?

        expect(student).to be_valid
      end
    end

    context "validations invalid fields" do
      it "is invalid without a name" do
        student = build(:student, name: nil)
        student.valid?

        expect(student.errors[:name]).to include("can't be blank")
      end

      it "is invalid without a document" do
        student = build(:student, document: nil)
        student.valid?

        expect(student.errors[:document]).to include("can't be blank")
      end

      it "is invalid without a email" do
        student = build(:student, email: nil)
        student.valid?

        expect(student.errors[:email]).to include("can't be blank")
      end

      it "is invalid without a academy" do
        student = build(:student, academy: nil)
        student.valid?

        expect(student.errors[:academy]).to include("can't be blank")
      end
    end
  end

  describe "duplicate informations " do
    before :each do
      @academy = create(:academy)
      @student = create(:student, academy_id: @academy.id)
      @other_student = build(:student,
        name: @student.name,
        document: @student.document,
        email: @student.email,
        academy_id: @student.academy_id
      )
      @other_student.valid?
    end

    it "is invalid with a duplicate document" do
      expect(@other_student.errors[:document]).to include("has already been taken")
    end

    it "is invalid with a duplicate email" do
      expect(@other_student.errors[:email]).to include("has already been taken")
    end
  end

  describe "return student information" do
    before :each do
      @academy = create(:academy)
      @student = create(:student, academy_id: @academy.id)
    end

    it "return a student info" do
      expect(@student.infos).to eq "#{@student.name}, #{@student.document}, #{@student.email}"
    end

    it "returns a sorted array of results that match" do
      academy = Academy.create(
        academy_name: 'Fatec Praia Grande',
        director_name: 'Nelson',
        address: 'Praça 19 de maio, Praia Grande/SP',
        phone: '3425-9652',
        email: 'fatecpg@fatec.com.br'
      )

      other_student = Student.new(
        name: 'Antonio Pedro Nogueira Junior',
        document: '533.968.828-31',
        email: 'user@email2.com',
        academy_id: 1
      )

      another_student = Student.new(
        name: 'Antonio Carlos Nogueira Junior',
        document: '533.968.828-33',
        email: 'user@email3.com',
        academy_id: 1
      )

      expect(Student.by_letter("A")).not_to include other_student
    end
  end
end
