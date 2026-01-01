class Schema < GraphQL::Schema
  query Types::QueryType
  mutation Types::MutationType

  # エラーハンドリング
  rescue_from(StandardError) do |err, obj, args, ctx, field|
    Rails.logger.error("GraphQL Error: #{err.message}")
    raise GraphQL::ExecutionError, "エラーが発生しました: #{err.message}"
  end
end

