module Types
  class QueryType < BaseObject
    description "The query root of this schema"

    # すべてのユーザーを取得
    field :users, [UserType], null: false, description: "すべてのユーザーを取得"

    # IDでユーザーを取得
    field :user, UserType, null: true, description: "IDでユーザーを取得" do
      argument :id, ID, required: true, description: "ユーザーID"
    end

    def users
      User.all
    end

    def user(id:)
      User.find_by(id: id)
    end
  end
end

