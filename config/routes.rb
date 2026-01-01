Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # GraphQLエンドポイント（GETとPOSTの両方をサポート）
  post "/graphql", to: "graphql#execute"
  get "/graphql", to: "graphql#execute"

  # GraphiQL（開発環境のみ）
  if Rails.env.development?
    begin
      mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
    rescue NameError => e
      Rails.logger.warn "GraphiQL could not be loaded: #{e.message}"
    end

    begin
      mount Graphql::Voyager::Rails::Engine => "/graphql-voyager", as: "graphql_voyager", graphql_path: "/graphql"
    rescue NameError => e
      Rails.logger.warn "GraphQL Voyager could not be loaded: #{e.message}"
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
