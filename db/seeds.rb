# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# サンプルユーザーデータ
User.find_or_create_by!(email: "alice@example.com") do |user|
  user.name = "Alice"
  user.bio = "GraphQLを学んでいる開発者です"
end

User.find_or_create_by!(email: "bob@example.com") do |user|
  user.name = "Bob"
  user.bio = "RailsとGraphQLが好きです"
end

User.find_or_create_by!(email: "charlie@example.com") do |user|
  user.name = "Charlie"
  user.bio = "フルスタックエンジニア"
end

puts "サンプルユーザーを作成しました！"
