module Types
  class UserType < BaseObject
    description "ユーザー情報"

    field :id, ID, null: false, description: "ユーザーID"
    field :name, String, null: false, description: "ユーザー名"
    field :email, String, null: false, description: "メールアドレス"
    field :bio, String, null: true, description: "自己紹介"
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: "作成日時"
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: "更新日時"
  end
end

