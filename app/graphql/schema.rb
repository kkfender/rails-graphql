class Schema < GraphQL::Schema
  query Types::QueryType
  mutation Types::MutationType

  # GraphQL Rubyのバージョン2.0以降では、以下の設定が推奨されています
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST
  use GraphQL::Pagination::Connections

  # エラーハンドリング
  rescue_from(StandardError) do |err, obj, args, ctx, field|
    Rails.logger.error("GraphQL Error: #{err.message}")
    raise GraphQL::ExecutionError, "エラーが発生しました: #{err.message}"
  end
end

