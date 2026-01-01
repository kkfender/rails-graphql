# GraphQL Ruby チュートリアル

このプロジェクトは、GraphQL Rubyを学ぶための基本的なセットアップです。

## 📚 目次

1. [GraphQLとは](#graphqlとは)
2. [プロジェクト構成](#プロジェクト構成)
3. [基本的な使い方](#基本的な使い方)
4. [クエリ（Query）](#クエリquery)
5. [ミューテーション（Mutation）](#ミューテーションmutation)
6. [型（Type）](#型type)
7. [次のステップ](#次のステップ)

## GraphQLとは

GraphQLは、APIのためのクエリ言語です。REST APIと異なり、クライアントが必要なデータだけを指定して取得できます。

### 主な特徴

- **必要なデータだけを取得**: クライアントが要求したフィールドだけを返す
- **単一エンドポイント**: `/graphql` 一つで全ての操作が可能
- **型安全**: スキーマで型が定義されているため、エラーを早期に発見できる
- **自己文書化**: スキーマから自動的にドキュメントを生成できる

## プロジェクト構成

```
app/
  graphql/
    mutations/          # ミューテーション（データの作成・更新・削除）
      base_mutation.rb
      create_user.rb
    types/              # GraphQLの型定義
      base_*.rb         # ベースクラス
      user_type.rb      # ユーザー型
      query_type.rb     # クエリの定義
      mutation_type.rb  # ミューテーションの定義
    schema.rb           # GraphQLスキーマのルート
  models/
    user.rb             # Userモデル
  controllers/
    graphql_controller.rb  # GraphQLエンドポイント
```

## 基本的な使い方

### 1. セットアップ

```bash
# 依存関係のインストール
bundle install

# データベースの作成とマイグレーション
rails db:create db:migrate

# サンプルデータの投入
rails db:seed

# サーバーの起動
rails server
```

### 2. GraphiQLにアクセス

開発環境では、ブラウザで以下のURLにアクセスできます：

```
http://localhost:3000/graphiql
```

GraphiQLは、GraphQLクエリを試すための対話的なエディタです。

## クエリ（Query）

クエリは、データを取得するための操作です。

### すべてのユーザーを取得

```graphql
query {
  users {
    id
    name
    email
    bio
  }
}
```

### 特定のユーザーを取得

```graphql
query {
  user(id: "1") {
    id
    name
    email
    bio
    createdAt
    updatedAt
  }
}
```

### フィールドを選択的に取得

GraphQLの強みは、必要なフィールドだけを指定できることです：

```graphql
# 名前とメールだけ取得
query {
  users {
    name
    email
  }
}
```

## ミューテーション（Mutation）

ミューテーションは、データを作成・更新・削除するための操作です。

### ユーザーを作成

```graphql
mutation {
  createUser(
    name: "田中太郎"
    email: "tanaka@example.com"
    bio: "プログラマーです"
  ) {
    user {
      id
      name
      email
    }
    errors
  }
}
```

### エラーハンドリング

バリデーションエラーが発生した場合、`errors`フィールドにエラーメッセージが返されます：

```graphql
mutation {
  createUser(
    name: ""
    email: "invalid-email"
  ) {
    user {
      id
    }
    errors
  }
}
```

## 型（Type）

GraphQLでは、すべてのデータは型で定義されます。

### UserTypeの例

```ruby
module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :bio, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
```

### 型の種類

- **Scalar型**: `String`, `Int`, `Float`, `Boolean`, `ID`
- **Object型**: カスタム型（例: `UserType`）
- **List型**: `[UserType]` - 配列
- **NonNull型**: `String!` - null不可

## 実践例

### 1. 新しいクエリを追加する

`app/graphql/types/query_type.rb`に追加：

```ruby
field :user_count, Int, null: false, description: "ユーザー数"

def user_count
  User.count
end
```

### 2. 新しいミューテーションを追加する

`app/graphql/mutations/update_user.rb`を作成：

```ruby
module Mutations
  class UpdateUser < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :bio, String, required: false

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, bio: nil)
      user = User.find(id)
      
      user.name = name if name
      user.bio = bio if bio

      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
```

`app/graphql/types/mutation_type.rb`に登録：

```ruby
field :update_user, mutation: Mutations::UpdateUser
```

## 次のステップ

1. **認証の追加**: ユーザー認証を実装
2. **リレーション**: ユーザーと投稿などの関連を追加
3. **ページネーション**: 大量のデータを効率的に取得
4. **サブスクリプション**: リアルタイム更新（WebSocket）
5. **バッチローディング**: N+1問題の解決（graphql-batch gem）

## 参考リソース

- [GraphQL Ruby公式ドキュメント](https://graphql-ruby.org/)
- [GraphQL公式サイト](https://graphql.org/)
- [GraphQL学習リソース](https://graphql.org/learn/)

## よくある質問

### Q: REST APIとGraphQLの違いは？

A: REST APIは複数のエンドポイント（`/users`, `/posts`など）を持つのに対し、GraphQLは単一のエンドポイント（`/graphql`）で全ての操作を行います。また、GraphQLはクライアントが必要なデータだけを指定できるため、オーバーフェッチングを防げます。

### Q: パフォーマンスはどうですか？

A: GraphQLは柔軟性が高い反面、適切に実装しないとN+1問題が発生する可能性があります。`graphql-batch`などのgemを使用して、データベースクエリを最適化することを推奨します。

### Q: エラーハンドリングはどうするの？

A: GraphQLでは、エラーは`errors`フィールドに返すか、`GraphQL::ExecutionError`をraiseします。バリデーションエラーなどは、ミューテーションの返り値に`errors`フィールドを含めるのが一般的です。

