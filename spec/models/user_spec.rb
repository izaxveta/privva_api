require 'rails_helper'

RSpec.describe 'User' do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without an email' do
        user = User.create(name: 'John Doe')

        expect(user).to be_invalid
      end

      it 'is invalid without a name' do
        user = User.create(email: 'john.doe@mail.com')

        expect(user).to be_invalid
      end

      it 'is invalid without a properly formatted email' do
        user = User.create(name: 'John Doe', email: 'john.doe.at.mail.com')

        expect(user).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a name and email' do
        user = User.create(name: 'John Doe', email: 'john.doe@mail.com')

        expect(user).to be_valid
      end
    end
  end

  context 'relationships' do
    it 'has many reported_issues' do
      reflect = User.reflect_on_association(:reported_issues)
      expect(reflect.macro).to eq(:has_many)
    end

    it 'has many assigned_issues' do
      reflect = User.reflect_on_association(:assigned_issues)
      expect(reflect.macro).to eq(:has_many)
    end
  end
end