require 'faker'

class User < ApplicationRecord
  validates_uniqueness_of :username

  def self.generate
    username = Faker::Name.unique.name.gsub(' ', '.').downcase

    create(username: username)
  end
end
