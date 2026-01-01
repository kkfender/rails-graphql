module Mutations
  class CreateUser < BaseMutation
    description "新しいユーザーを作成"

    # 入力引数の定義
    argument :name, String, required: true, description: "ユーザー名"
    argument :email, String, required: true, description: "メールアドレス"
    argument :bio, String, required: false, description: "自己紹介"

    # 返り値の定義
    field :user, Types::UserType, null: true, description: "作成されたユーザー"
    field :errors, [String], null: false, description: "エラーメッセージ"

    def resolve(name:, email:, bio: nil)
      user = User.new(name: name, email: email, bio: bio)

      if user.save
        {
          user: user,
          errors: []
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end

