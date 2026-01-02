# lib/tasks/graphql_dump.rake
namespace :graphql do
  desc 'Dump GraphQL schema to schema.graphql'
  task dump_schema: :environment do
    schema_definition = Schema.to_definition

    File.write(
      Rails.root.join('schema.graphql'),
      schema_definition
    )

    puts 'schema.graphql updated.'
  end
end
