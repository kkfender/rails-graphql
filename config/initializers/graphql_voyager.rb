# GraphQL Voyagerを開発環境で読み込む
if Rails.env.development?
  begin
    require 'graphql/voyager/rails'
  rescue LoadError => e
    Rails.logger.warn "GraphQL Voyager could not be loaded: #{e.message}"
  end
end

