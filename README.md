# Rails GraphQL プロジェクト

GraphQL Rubyを使用したRails APIプロジェクトです。

## セットアップ

### 1. 依存関係のインストール

```bash
bundle install
```

### 2. データベースのセットアップ

```bash
# PostgreSQLサーバーを起動（Docker Composeを使用する場合）
docker-compose up -d db

# データベースの作成とマイグレーション
rails db:create db:migrate

# サンプルデータの投入
rails db:seed
```

### 3. サーバーの起動

```bash
rails server
```

## GraphQLエンドポイント

- **GraphQL API**: `POST /graphql`
- **GraphiQL（開発環境）**: `http://localhost:3000/graphiql`

## 基本的な使い方

### クエリ例

```graphql
# すべてのユーザーを取得
query {
  users {
    id
    name
    email
    bio
  }
}

# 特定のユーザーを取得
query {
  user(id: "1") {
    id
    name
    email
  }
}
```

### ミューテーション例

```graphql
# ユーザーを作成
mutation {
  createUser(
    name: "山田太郎"
    email: "yamada@example.com"
    bio: "GraphQLを学んでいます"
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

## 参考リソース

- [GraphQL Ruby公式ドキュメント](https://graphql-ruby.org/)
- [GraphQL公式サイト](https://graphql.org/)
