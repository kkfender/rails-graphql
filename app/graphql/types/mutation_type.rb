module Types
  class MutationType < BaseObject
    description "The mutation root of this schema"

    field :create_user, mutation: Mutations::CreateUser
  end
end

