require 'faker'

class User < ApplicationRecord
  include Clearance::User
end
